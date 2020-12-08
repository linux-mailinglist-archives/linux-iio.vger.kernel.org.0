Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E612D2F1B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 17:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgLHQHn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 11:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgLHQHn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 11:07:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4BDC061749
        for <linux-iio@vger.kernel.org>; Tue,  8 Dec 2020 08:07:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b4so16680086lfo.6
        for <linux-iio@vger.kernel.org>; Tue, 08 Dec 2020 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=G1xyUg/oYfs3hLFskl8L3RYEleL96yy5NwGE4uRUbEY=;
        b=ATXbSSlqkq5qUMHB59EXrhwSGcCp1Qpa0/pedHW84qTseye8rVcMmRxnpEPDK8la0S
         xhFcRUiif3deWxH/V7FjCFxU6jxXFcG1neKWz52UZZWG6aOV+PVefKIHbsW6KSwgWt3a
         yeCvOGBjplAwNXMYzlR9HlUDcIXXvPBGdtfmp3GBCtVnRo6VfMhGqRZgk5HRdNyYIT3x
         LJZqevF6cz/97HA5p+HSErOnFY0QAgZbiA7z2Pb4b087ndWNn8Aw9nD4ntG344yTUzy1
         CAqfYUKkhXzZzAUynB+/GFBj3IcdO5IhIaB6+wu5YNUJQ3hf7nQ4/oDwPFumEUaH7Ysr
         E4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G1xyUg/oYfs3hLFskl8L3RYEleL96yy5NwGE4uRUbEY=;
        b=Lvtc+TcsH+AzmzzRDqcfPrFn9ew3Q0/5vcxeVm7blw1JYT9p9Y7sR4E1XOuSXYi4uO
         0XW/uiexfj19DCUXvJQpb2ZtQFKpPGCBVs7YY4MjdRa90t0VUlZkU6ntnEftQClZSWYD
         sWXE27Q8wsQwKQQANedWHJCqw81VaYrCKKVI5oj28T2fJ3Ly++tMHToAw8B0nQmisnen
         qPclsFqj4Y3SLtdHTX5o/J5jtIpWhxnofG0PN1S50lBG0qx4O13RREATfkALiXz0LZDx
         xeDfFI6tLV/mGLKYryEKJ7SkaLu04TeTxC+sMBg8XmHZvXEkJpQqsz8sx9a8PxM8AuTl
         j37g==
X-Gm-Message-State: AOAM532nNAGuGpp6UV1e8Omnn0w/gXczJOA1TCAOIvNydCvKGLnUMNE7
        RjBFy8Y2z512uMl99yND3NwNc+qc2FtIQEQiXa3TMuC5cUulrw==
X-Google-Smtp-Source: ABdhPJxQLYEbJYCKRLP+UkhcVmk5S3FgHjcR1LteaVvgVmhOVGdILexSQqv8io24SbHC3frtO8jTqvoJTOy50MzzDBM=
X-Received: by 2002:a19:ad44:: with SMTP id s4mr9906659lfd.254.1607443620299;
 Tue, 08 Dec 2020 08:07:00 -0800 (PST)
MIME-Version: 1.0
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 8 Dec 2020 21:36:48 +0530
Message-ID: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
Subject: IIO Driver for TMP117 Temperature sensor
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I have this TI's TMP117 sensor with me and I was thinking about writing an
IIO driver for it as a hobby project. Is the IIO subsystem the correct
place for this driver? if yes, can someone help me get started with this,
I haven't written an IIO driver before. I have this sensor and also a
raspberry pi with me for testing.

-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
