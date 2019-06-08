Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B902399FD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 03:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfFHBNa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 21:13:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfFHBNa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2019 21:13:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so2077997pfe.11;
        Fri, 07 Jun 2019 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZnrgNgM1Cs0qOJGeQHKSRlX2rRFjA19oSQ5s7deLBTA=;
        b=ppklb12QOy6NgfVPHHRiTXwbqKAmoNApZg8EEEgzCqUiLuO0PZfXjsGhob5iR/MlGB
         am+msKi1lJxeQ4okObxg3+kQUj32u2QvjzvvO+O54aqYzOdDdQvZPW2+ZkdS8U+FgncE
         dExJNtyigc74panwy9TE8ePEPQCdDwxsiyBLsqO9fLR0Zo4tTMztV3XgRHmwykMeM/v6
         eU4Wj9N2mXdjHakGi7wi7HUBWnos/qr3fmfDvtDf8TKFYhlljyYFAEZlCQxMu0hcRnju
         1SweomxDsHnBqx7cHFfy3sL94MJz1bfNO2mU3ULctdLMQ9b2EO8Q+3oYz7RP0AEOE9A9
         vnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=ZnrgNgM1Cs0qOJGeQHKSRlX2rRFjA19oSQ5s7deLBTA=;
        b=e8q9c0gMSBbht5siAU3aqqpinNIh+I0VOqVuiKjslRCB87lRKKtA1wG7udyz+013uV
         jPKRp3FzdWh7zlg/qf1JJRFCgnGO5YpsoCVkySTd2pYpwyYYpFpG0Xj6uY+B83dMQQfb
         9z7TiDM5Q619M9xEHfiF3jM/yiRUn0RELSPwQMWVAomSEFl9FwCHg/kcgfhdPRwrV22J
         BDeSeS4JIH8BmP+iW/9oOVLf5f96IfsQROw2AWgFLl3oJdb9UdB/xFS8EUcF4yWT0xkq
         XRhUvxH3X6A/V8aiupAlQaDGqxF7N+vVjUdBq5M1b6fRvVvwmBiYRKdcergzho3EGA3V
         Q6hA==
X-Gm-Message-State: APjAAAW5isVTqYpgutUIu1M/y5Lx0ZwKHjtYnVqITeZwRbZcSMVgli/G
        7d3/HWvDaESOEsHNYBw6/phdKH1P
X-Google-Smtp-Source: APXvYqxEF0yS7w616Sc0TkXFPNEVuIlTLcClLu/qb557MkDs1BB/07PskKA3WCJK4FiRtcuNH6ETRw==
X-Received: by 2002:a62:3145:: with SMTP id x66mr63131927pfx.223.1559956409772;
        Fri, 07 Jun 2019 18:13:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm2930968pgq.48.2019.06.07.18.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 18:13:29 -0700 (PDT)
To:     Jonathan Cameron <jic23@kernel.org>, Dirk Eibach <eibach@gdsys.de>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Removing ADS1015 driver from hwmon subsystem
Message-ID: <4aaa9d0c-2ed9-ccd2-2d84-a5bda4ea4a23@roeck-us.net>
Date:   Fri, 7 Jun 2019 18:13:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

there are currently two drivers for ADS1015 in the linux kernel:

drivers/iio/adc/ti-ads1015.c
drivers/hwmon/ads1015.c

The driver in the iio subsystem provides more flexible support for
the chip's capabilities. Even if the hwmon driver is removed,
the iio->hwmon bridge can still be used and would provide the same
information as before to the user. Existing devicetree entries
for ads1015 both point to the iio driver. The platform include file
is only included by the drivers, but not from any platform code.

With that in mind, keeping the hwmon driver around does not really
add value. I suggest to remove it. Are there any objections or
concerns ?

Thanks,
Guenter
