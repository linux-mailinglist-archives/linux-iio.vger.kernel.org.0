Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313E68B373
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBFAth (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 19:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFAtg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 19:49:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A915126ED
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 16:49:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mi9so10132263pjb.4
        for <linux-iio@vger.kernel.org>; Sun, 05 Feb 2023 16:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WgKK2iU2+/3OH7dzNX0z3gW6pxqrg9aggpWT5v1u0QA=;
        b=Bqg8axm3YO6buDujYzwkaNb+9/59JI5YoPkwiH0Qao9H3TdDdJGkjRet050L4hFadO
         whZ02XUnGydUTcUAnCclt8Lf6koZnIHymcZdXCbQqwRkhVA8e2j2BKWVbJBKFhJXWHpq
         BxDe4I63hRm+eeZVz0uamc33nn9yuDbNAMFJC/L5GTgMTVz5jgmWZMxtOh3usmSjjTaU
         PoG0bL52dz0uUT1RCzyIWnzE/tTnwaRJtB1LaMRtdsrbfsJjHVcvCPMfD77w8toHi6bL
         POxU+iq3ErcrFzNYz6A/CbLqMhRlK59hlPlObX34L+6L8SccqfobgVT8OYdXZSebk7nI
         Micw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgKK2iU2+/3OH7dzNX0z3gW6pxqrg9aggpWT5v1u0QA=;
        b=BZbnM0pldn5ji3VJ5z5YSyX/A0E8J7cv0DpifsS5/iABq7THQsVqZbLOvrFkRSzQ8N
         Mc47owtGyIG362QuQiO+mwbNvsuytaZDZl1HutFYtoq9pb5Q3h39e7Twnus7UGRx/Ptk
         al1E6hc+GrZjb4PUZjoqIDnnLuUDlq1b3FEF5wrY90TyIIa8mg8wP1QVU3zXbcFaSlHW
         Mv7ZIEev2f1q2a2Dj5aAI+BeWM3vB63Hfxmf8+HGrJnyJxfVpoTl2kKq1tRz4at0gdc8
         M5tO9I/RgNrPE99PIc6hh8yykCj8vdVNBX4BOL0vp7ijhmKmtgQRN/4wvtdduC2TKfe7
         BVNg==
X-Gm-Message-State: AO0yUKV8+Hho2KmmAvGsswt69Bn6kMCPUQwdlQihSQSzUxHiv+JEM2t+
        BCmsyiXp5m31HpgrkckWAwN11j1cQWhqWrfsjHDEx49ukD0=
X-Google-Smtp-Source: AK7set8AReoCeHGhvSiJe6b/UbVaNXNrIo2kW1V2/L6Dytc+pxRJvA2soReHgMnmSClnFcoWDKxr2PZ1xZTVtrPzLBw=
X-Received: by 2002:a17:90b:1001:b0:230:ca06:f0fc with SMTP id
 gm1-20020a17090b100100b00230ca06f0fcmr53165pjb.95.1675644575543; Sun, 05 Feb
 2023 16:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20230130201018.981024-1-jic23@kernel.org> <20230130201018.981024-3-jic23@kernel.org>
 <CAMxBKG2+XOvXs-89hakTcxH_FPnTjSBkbbuuCjGwVSObLPBFkw@mail.gmail.com> <20230205142312.4c75e7c6@jic23-huawei>
In-Reply-To: <20230205142312.4c75e7c6@jic23-huawei>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Mon, 6 Feb 2023 00:49:24 +0000
Message-ID: <CAMxBKG1wJYReeQSFp_NHBKWdDjxobsDBrbFP2f8WvMT=cZRj5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Feb 2023 at 14:09, Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi Darrel,
>
> Once the other thread has reached a conclusion, if you could give
> a Tested-by tag or reply here with what is wrong, that would be great.
>
> Due to bad timing this may well have to wait for next cycle now, but it
> would be good to at least get it queued up for mainline.
>
> Jonathan
>

Hi Jonathan,

I confirm that the patches work as expected, both on kernel 6.2.0-rc6
and backported to 6.1.0-2.

Tested-by: Darrell Kavanagh <darrell.kavanagh@gmail.org>

Darrell
