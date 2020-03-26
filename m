Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E119457E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZReX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 13:34:23 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:38134 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZReX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 13:34:23 -0400
Received: by mail-pf1-f178.google.com with SMTP id c21so2470663pfo.5
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2020 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j4wYzjIKWLglF/mMaJDlsjtFZT0DVD4al1LKz0FBi3s=;
        b=SLHwSia+7qKp8LWnRMYAs4dOnXSqpyeNVvONeesi6sMv1mHsIeGsx76KwSCYAd0iFx
         Z072HhfWVED23GAI3cVTjzA1c1hUUAcnw1SL+pN86cK81ezkSoavv6CysATDngSq8oVH
         cTkw+2AvDEQwgh25SDFPWSXWf4+Pwtjuj6E5CGiRQFfnDI3P6Os1BXFsYetrF8yOwDOo
         QyyOZEw5cpAzUuE6JaRkH+WDkteQEeZr4pCG0RmaI+Nvy/t4t4VUl9jxvi9ZiY/6siqC
         yswY5sC6YUAPpNynTRpjv7GapynIyhK8Pe40Je5+UgbppIrNbgkOFbEtB6HUH+g2z2PC
         D8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j4wYzjIKWLglF/mMaJDlsjtFZT0DVD4al1LKz0FBi3s=;
        b=rZnYg3JgbtOA10XgQeIvIZuEqW+aq+bUeG0u9wHJLhzD3EsaUKyqwcfKnBn3hIWMJn
         UaCbZNBrCRwnaevNoEN51A2GF+1dcxhH3UfIiNa3eEv1MkMEarAaTRDWh/Q2+nXozuNl
         KfIuqIlazJww/H2F8pGWN5erHBZ9b/p05jqxQoUIBdhgqRGNhb7IcxjqxBS6R/JAv1dC
         Jk1oqLJw9XP16B2fQQuH5lMITgJvaHyFNQNUvgir0I9vVCIYFGyRvfYEBGJusgkLCKKF
         7hEa1lPR7qkDPnRldKNvpDdQwLA5yqF4tiMv+Rxywyr53RHVf36qGFMFf6oS669rrpaJ
         CUBQ==
X-Gm-Message-State: ANhLgQ0jP8Iu7MAxWK2WIQhySxfmgN91Uiog2iBUFwZfg+GT6e9NmgL0
        r0cYIJMihq8jeOGVa9UPl9tuvfAOyG8=
X-Google-Smtp-Source: ADFU+vth0dlpC5kvbO+UCuE/G9NdUqgmmWjXAXTjw6fwsk6z+bOL0uadOG0+SRb0v7JCj1AVZi9V0A==
X-Received: by 2002:a63:7515:: with SMTP id q21mr8558978pgc.46.1585244061948;
        Thu, 26 Mar 2020 10:34:21 -0700 (PDT)
Received: from ?IPv6:2409:4072:6219:b2ea:b8ba:b1e9:ddf7:4d7d? ([2409:4072:6219:b2ea:b8ba:b1e9:ddf7:4d7d])
        by smtp.gmail.com with ESMTPSA id v42sm2129844pgn.6.2020.03.26.10.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 10:34:16 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
Subject: [RFC] IIO Driver for GSoC 2020
To:     linux-iio@vger.kernel.org
Cc:     Dragos.Bogdan@analog.com
Message-ID: <147e6ea7-5022-e131-8cec-14fa22278703@gmail.com>
Date:   Thu, 26 Mar 2020 23:04:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello IIO,

The project proposal for GSoC 2020 under The Linux Foundation [1] must 
include a Analog Devices, Inc.'s component for which a novel driver is 
to be implemented. My search for a prospective device has culminated to 
consider ADXRS290 Gyroscope. About ADXRS290:

- Ultra-low Noise, Dual-Axis (Pitch and Roll) MEMS Gyroscope
- "Recommended for New Designs" phase
- SPI digital output
- Datasheet in [2]
- Product overview in [3]

The existence of any compatible drivers for the above component was 
looked for in Analog Device, Inc.'s page that lists all drivers [4] and 
their kernel tree [5] and the Linux Kernel Driver database (LKDDb). It 
was found to be void and ergo my decision to choose the aforementioned 
component.

Is there any other factor I should consider before choosing a component 
to make a driver for? Do I go ahead with ADXRS290 gyroscope in my 
proposal? If yes, are there any recommendations/suggestions you'd like 
to provide for a beginner indulging in making a kernel driver for such a 
component?

Thank you for your time.

With regards,
Nishant Malpani

[1] https://wiki.linuxfoundation.org/gsoc/2020-gsoc-iio-driver
[2] 
https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
[3] https://www.analog.com/en/products/adxrs290.html#product-overview
[4] https://wiki.analog.com/resources/tools-software/linux-drivers-all
[5] https://github.com/analogdevicesinc/linux
