Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92CA591C7B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 22:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbiHMUAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiHMUAD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 16:00:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162AA13CD0
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 13:00:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kb8so7293359ejc.4
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SqEK3dSOL0OGEhaO3b0fErkGK/VagcMr1SpmxVH4cXk=;
        b=ed2CnEFSDsafYfCoEs0urH2W3kw1Q8GXaSIt46m5U4f07agYes+gkKpVFexkMY52+u
         btR2GK6n/aTgPUQk48FE7N0562Xzacv4PegAsz5pqK/Ghbj2bHNtKcd9Bk4FBhMWfT0Q
         M9v0VWu31bvzyoltKEwtAhd1nGlxvE4nj/cgAXEFevE1yQF2lUHuoEDan4n6OQUAZvtx
         VG24AUpqxzLmvOpt3Gxyf3erNKh+JkBXkIsgGvPbikekWEqX+vPnL1BrW6I6wXXS6FYp
         y76DQ82oH6hN/lE0rarbMALPlEoSlVPzM44sXTTLWs8p9+yut/ey7Ka7QsClH4xN3VB4
         gPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SqEK3dSOL0OGEhaO3b0fErkGK/VagcMr1SpmxVH4cXk=;
        b=Zv/gljKD9Ex0FVarz6WQW0O3BGcQNHAAaqIORAELOOw68CtOmf9JY2IdF5QC21S59a
         Vn7J3sFErYWpNAv1O9D8wFR6ZGaUQliTxgoD0cwMCJFexkVq3yLzg1yFSqiy7O7fQmNZ
         g8l/H7wqNofm/tBVDc2FRyi55CksSETIlzcwFR5lcg13W6qvz8CKV5EQe4jbiWy8Gqvw
         DliJkQJPoWt6Z2whdbAqL8BWk6dxwNBQFsIimVQEdxx6uTLwKZAfXNCkkY1SAU/4fIyA
         e2nphZGgFXzq8iHRGdMnvWNe6W9WR+jAPQYNkQtwSrrG9aO6k4/xahycdIyY5ZR8odBt
         i1uw==
X-Gm-Message-State: ACgBeo39gYGbCvhB8FcSOVgTIEHIMjyK7xc4tD523u8mwDdWg1NtS2Pe
        BfNxjsL3nL9JdRddspYkmCgpllUFwikKGMK4hbdGCw==
X-Google-Smtp-Source: AA6agR6ULIPx7Wq+VpWSTgoMR+Bq3GuaHe93aIu9VStvYfUxhfa3vVhwgsXQwaLQ2w4h9oZAVB/5AryDlgbH0fxkaHQ=
X-Received: by 2002:a17:907:6d98:b0:731:2bb3:8e17 with SMTP id
 sb24-20020a1709076d9800b007312bb38e17mr6256678ejc.203.1660420800573; Sat, 13
 Aug 2022 13:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660337264.git.jahau@rocketmail.com> <1a8bffdb7e807455620a73f2d61981e7f9aab8d5.1660337264.git.jahau@rocketmail.com>
In-Reply-To: <1a8bffdb7e807455620a73f2d61981e7f9aab8d5.1660337264.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 13 Aug 2022 21:59:49 +0200
Message-ID: <CACRpkdaP9hH7LjJ_B2JvkgzmH_UZsW_oB2SYR4xqSp0LYgvBrg@mail.gmail.com>
Subject: Re: [PATCH v6 12/14] iio: magnetometer: yas530: Add temperature
 calculation to "chip_info"
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 13, 2022 at 12:05 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> Add temperature calculation to the "chip_info" structure to ease the handling
> of different YAS variants.
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
