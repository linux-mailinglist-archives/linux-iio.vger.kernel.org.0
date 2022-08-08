Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D158C56F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiHHJTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiHHJTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 05:19:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7913F6B
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 02:19:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id d10so365360qvn.8
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2022 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=toARq6+YjfznU7JL+dv47/dc1C5Fjp6EKvhLDC54y0I=;
        b=DUoC2Ri/o0/mDyneFFlNGIUo226h5aAG/Mx02/eufaYVV5II3zFmmaGaET3gTTuqD0
         IvYcQ/NPD4LWvDMWKHUarHSs6EMNdQPEkFrcgwqNGrkRK13ix9ZMCImqdZmnIKjgO8Hz
         FAH5UY2p9vTWL+5Nmp5abokeUF+xG717GnreWGXVlf7hQPcaCkQQ2HhlivpLq7sT4fr8
         7shbXvr3HOT6kd16ndNXlbHRuxNF03AYPqM42IaU4pDQs0fPn6DkE9AzD3t3HDPTeMTO
         Q3Osj3Cbit0Dn3Zk7aCCE0uhkgLYSFotLjCZonPsZAtduU5p7eXrcveg/BgYN3xuW9he
         +JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=toARq6+YjfznU7JL+dv47/dc1C5Fjp6EKvhLDC54y0I=;
        b=txD98Rrcu9DFhX86L1j1vDE/XgwNxBzO3eH+YM3Yv0hwRo7fYGCi2jjnSD24qKueB/
         UEvALBOPt8cFtcFXMF1InEVbRG0vhqUrEqgvuHDSBsmpkbEIzOKA5eX4UfetAggCcukj
         l3Lku0fQn0r0BHusgPvmTnOcxDHx1uV1fGYK0byZV3XfFFWdg92ToiQKZTFczCVvq3Bv
         BVjUxmVxXdyGxNoeSWvPghzvUVGe9LByn2P+aUwXMzrpnGHX1/q+jqZI0rNXz4PTeRy1
         vzxVejMF4M+DD1dYwa9znBdfpIG+d+ymR6wZ6D+hFYvIjX5d3sy60TOlCI6curtnQPiP
         X30g==
X-Gm-Message-State: ACgBeo36QJLSqNzF42IoY9tpU1+S9llJbPJ5ZNOHcnw49dAt/rCJALdx
        LPtM5NE6yaE18O4kgZy/2YBEFe0RNjEoBRQxFFXWOnqVxus=
X-Google-Smtp-Source: AA6agR6SvLrjuqZ5ewkzwzm1O6P3IimXu4Rul3LdIEO0OYYZpiLoceTkL+swutYQb44UUJQ4qcZHZo9u+GWVLcaOXtI=
X-Received: by 2002:a05:6214:d07:b0:476:c32f:f4f4 with SMTP id
 7-20020a0562140d0700b00476c32ff4f4mr15407201qvh.11.1659950350879; Mon, 08 Aug
 2022 02:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220807151218.656881-1-jic23@kernel.org> <20220807151218.656881-2-jic23@kernel.org>
In-Reply-To: <20220807151218.656881-2-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:18:34 +0200
Message-ID: <CAHp75Vd34hOAMpeCwcYjnuVWUSN7WuGGwc1qiKqNp+xpmsEXkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] staging: iio: frequency: ad9832: Fix alignment for
 DMA safety
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 7, 2022 at 5:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_DMA_MINALIGN definition.

...

>         union {
> -               __be16                  freq_data[4]____cacheline_aligned;
> +               __be16                  freq_data[4] __aligned(IIO_DMA_MINALIGN);
>                 __be16                  phase_data[2];
>                 __be16                  data;
>         };

Hmm... Can we rather mark the entire union with it?

-- 
With Best Regards,
Andy Shevchenko
