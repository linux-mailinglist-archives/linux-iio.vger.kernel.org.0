Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA577333FB0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 14:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhCJNzK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 08:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhCJNyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 08:54:52 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3084C061760
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 05:54:52 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id w5so5796709uap.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bpp2KNRfFb1FPRjesfEUr+fLlrK1MB1SHzGKYD2L3Ds=;
        b=K5uCBnllHR36v4i2as6gQCqzf4U/FMyW0M45iDvQC5fEZxDBOwY/4XswayEb9MWfY+
         +z3+XGLbFRCOshcF4j2FG1o5OzaJGP94DIVIEZLGWTPN9PVT9YwSN3aMGVilkytr0UVC
         z6QWwB8RzseHkm/UzdqzrIClUX51/1jxfsaSVatTDVv73sDWQaxmnN2+FPZCa5WLrTKR
         9apBEsL9D48jUiNLuHMbpzLMkc5fhqeRtBGzMVrfIM1Z8dRDHbbWY7ezBs6bLTAsuA4+
         cVwvbwPyJctRdT9GeEA7eW8CG7duzFmRokoe1wiHk8/lGdqStz1RwMt3eNYVzrlX1Ia3
         MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bpp2KNRfFb1FPRjesfEUr+fLlrK1MB1SHzGKYD2L3Ds=;
        b=UCvy92Sq24Td+q/14vKSmZuLGBznnJ+abSt5fBLHaiL3059pJHteY3z0v4hWF7sQhP
         WDukWw3or28gWLjYsRXZA3r013p1yQWOsB+KT9utd/L7Vo+rtiSxRiR6edVZnSCL4CN8
         Oii72vp4+vasNh37o+QL+IygTj4r/wUnEFIlpisGR4/z/7URU5PfB4Lh0yf/Lk4zkFtq
         gJkO3nRaZ5ef2LoFCIZjT5HyO+/FySOEvBdQPN84aYIEhN+0PlLV+eTwODhf6qoU+8Lr
         kqIyaKoaEyc4h6Ho4zYjxowhSYipC2EQLq7TEYMWkKUljQIlqwBBzXe3SYm2OjqkX9zu
         DB8w==
X-Gm-Message-State: AOAM531slPYzBAcRSDXa9NQZoih6WjY1AaMomCTDOtei7r5h/CCHgpKe
        AXVW7tmZO8afoqMgc2mTwzxnZPjiQQ2RZoDbDfzRcRWNmNk=
X-Google-Smtp-Source: ABdhPJwNM1GpdYrBdpw1zmJg3b46MRfDyTCF8ajdcDZ/Wt0PbvQFak1yg6gryeK8zw5csCKv7lLexbgwZ7sM0w7ITMg=
X-Received: by 2002:ab0:c9:: with SMTP id 67mr1627952uaj.112.1615384491668;
 Wed, 10 Mar 2021 05:54:51 -0800 (PST)
MIME-Version: 1.0
From:   Utkarsh Verma <utkarshverma294@gmail.com>
Date:   Wed, 10 Mar 2021 19:24:39 +0530
Message-ID: <CANBZqrGur27Mn8upmfz216tz4ZsgZoVEJTjhgmhDbWT-5_kxZg@mail.gmail.com>
Subject: Contribution to linux-iio for GSOC 2021
To:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This is Utkarsh Verma. I am a 3rd year Bachelor of Technology
Undergrad in Electronics Engineering from HBTU, Kanpur, India.

I want to participate in GSOC this summer, by contributing to the IIO
subsystem. But more importantly, I want to be a part of this community
and get my hands dirty.

I have done the operating system course and know the very basics of
Linux Kernel. I have also read some chapters of the "Linux Device
Drivers" book. I am very new to the iio subsystem and I am still
reading the documentation and the conversation on the mailing list. So
if anyone can suggest some easy fixes/tasks for getting started would
really be appreciated.

I would be really happy to contribute.

Regards,
Utkarsh Verma
