Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3389BC0A09
	for <lists+linux-iio@lfdr.de>; Fri, 27 Sep 2019 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfI0RIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Sep 2019 13:08:23 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33216 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfI0RIW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2019 13:08:22 -0400
Received: by mail-pl1-f171.google.com with SMTP id d22so1347973pls.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Sep 2019 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=r5QO7JUixWQ+IXNJ116xMGnIqPmbQb4HGxmuYhmjwJ8=;
        b=NwZ/9to/rkFtRIvHtwMcGpzymkA7AbAw4E1I4YmD16FmdyOMzXUe7nTkAEdFAX+cJG
         vHMe1ww/W1JYN0gSGBFCoLWvuSgmD91/pWmvALDmu0NRxoqN3AnZsi/9y1TvS4/N6bsA
         d5Xa0OXvtVsNbTBtHlBshHPAli2RTLqJAlQGgpPxoUWSKZ3dE3mhTfTDcLvGdqbQ3/mt
         v9ZKGcw/RxmaYapKEaOv40MZHOKypJokKfUCJNOXXY+mCvPD/PzCjJHY7xyaFARK7X/Z
         wC03/7Crx/1E8D0mRONEBvpsY0+U7DYVRpP5/woFsyUY/+00mhSlFoWjYekz8oeWzafc
         1D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=r5QO7JUixWQ+IXNJ116xMGnIqPmbQb4HGxmuYhmjwJ8=;
        b=lv1ty2ydWjsJ2iVQHVy/KV4xKTnlAzc+7bGJ5Mn81TEgx2xt2NOOul64GieOCRP5tK
         r+cagiZx0wkq0hWr9xkXQnb/QIPuFnQtjRyfQwYEe1+z9CeZnExwKmDkKoCLqEOQpWnA
         NyTVoNv+su06Gnl14EtKwKkovUnx7UdHrESpipSS0c0852K0iv3c+/rjXPw5aOaM074f
         U/emSUr6QOF+ddQePFzTDX66aRMgv+Eva/CWUD2W0PijftQwLUOWBYfc30I6AQxJt1bV
         XPCNSw+8JdCjKeg43dE64sv0hT/Jb+sfNksf/hFXCKKVIEhyDP82KR9zePEkPovUTNk8
         G+Hg==
X-Gm-Message-State: APjAAAVO7A4ZsrnU+Om9yH/3+e+w5qxSXa/JHpleOwN0WiWaQsd8bV+j
        SakwygaIHADSbFUmrB58cq84gr3Y8L7KGA==
X-Google-Smtp-Source: APXvYqxuNoWD7V0izDmY4sBSozfUZZp8zm1twQse0jGVFhQib3/UXplzy5yQAqMHJ1yzAlKnwg7KrQ==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7mr5733769plb.159.1569604101288;
        Fri, 27 Sep 2019 10:08:21 -0700 (PDT)
Received: from [192.168.1.13] ([172.103.152.101])
        by smtp.gmail.com with ESMTPSA id h26sm7299702pgh.7.2019.09.27.10.08.19
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 10:08:20 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
Subject: Adding "fault count" support to opt3001
To:     linux-iio <linux-iio@vger.kernel.org>
Message-ID: <a3335ddc-6961-79fa-308d-868e156960d1@gmail.com>
Date:   Fri, 27 Sep 2019 10:08:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

The TI opt3001 light sensor has a fault count field in its configuration
register.  See http://www.ti.com/lit/ds/symlink/opt3001.pdf on page 23.
Basically, this field controls how many samples must be above the high
threshold or below the low threshold in order to trigger the interrupt.
Currently the driver initializes this field to 0 meaning that one fault
will trigger an interrupt.

0b00 -> 1
0b01 -> 2
0b10 -> 4
0b11 -> 8

The driver has an IIO event which allows for the high/low threshold to
be set and enabled/disabled.  I would like to add the ability to specify
the fault count as well and I'm wondering how this should be done.  I
believe it should be done by adding a .mask_shared_by_type =
BIT(IIO_EV_INFO_???) definition within the struct iio_event_spec, but
I'm not sure if any of the existing IIO_EV_INFO_ values are appropriate.
 The only one that might be appropriate is IIO_EV_INFO_HYSTERESIS.

Am I going about this the right way?
Is IIO_EV_INFO_HYSTERESIS appropriate?
Should a new enum value be defined?

Thanks,
David
