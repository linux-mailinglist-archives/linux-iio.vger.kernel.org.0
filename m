Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7836978CDD3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbjH2Utu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjH2Ut0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 16:49:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011501BC
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:49:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500bdef7167so279036e87.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693342161; x=1693946961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmkFChDv+8wEuMHUlBFf+bYcihrh5O9J7mo8VcvR34o=;
        b=FmhS6P9ySkPh6Sp8QVJxTtJVYsMPtWzSyeTQdoATOWJshBm9ROI80i0ZRxjUDNXiZ9
         pr/44Tmf0B29P/dsSrq4JLjY49ZCfCu/2xU72byJ6/XrwFNmHvg/tc/nYxvDPsm47+y7
         Alxqb9zAhsJEqbueu4Cy5T5cICACb+j0OX9jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342161; x=1693946961;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmkFChDv+8wEuMHUlBFf+bYcihrh5O9J7mo8VcvR34o=;
        b=ZB0nsLRQwGnB4YWUzuuFqyQpXtw/ozXOWR2cLrqVQT+vKBUs2Czltat68cCp/16jU+
         cFzbtMY7L+U4/3nFTAMEXbVYXMWCu8vZ1UvXkO5voSKISQH2G88uEbU0PE1ligr1C3n7
         /bQj/VmoOpDTmOJsmSdrGJJSis3InnuSe/A8itlNMaTEhyg3Ew7TtKVRSQRzzGMDKrpl
         /QbEvSvmlEKbYJthBpRO1Dpxjsdu0FvTyJde9chLt2kLYnsO8uaftn4g1G9shZlX0SrF
         zGqC3YhONRydaxcM8JbxgwAV2wF+XnmudzJ3gu4pVlYdBEWTGFMa60clgR/4Wh792tZX
         cXPw==
X-Gm-Message-State: AOJu0Ywgq89gGpwSWzy5JluOgcIA5KaGVtNxmct+eZUUxfvKnSuxEpgq
        jfL/AdSpXHG1Rlmta6X2hhu0UshK1SDqZfQsWhKXSw==
X-Google-Smtp-Source: AGHT+IFXSgclTeRrHpYSYN/loka8vQax+6EBcpFkMLZs1lhOMNMRjt1rtXJLvpy0hz76lI9fJN44UHzMYt1HXgrg/K4=
X-Received: by 2002:a05:6512:3b29:b0:500:8676:aa7f with SMTP id
 f41-20020a0565123b2900b005008676aa7fmr1423753lfv.23.1693342161132; Tue, 29
 Aug 2023 13:49:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Aug 2023 15:49:20 -0500
MIME-Version: 1.0
In-Reply-To: <20230828133933.1ef5145a@jic23-huawei>
References: <20230818175819.325663-1-biju.das.jz@bp.renesas.com> <20230828133933.1ef5145a@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Aug 2023 15:49:20 -0500
Message-ID: <CAE-0n532Q_sj8AB0d-HhPun7id-cGgDwcNfqH3T4ATcjw01vsg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: sx9310: Convert enum->pointer for
 match data table
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2023-08-28 05:39:33)
> On Fri, 18 Aug 2023 18:58:19 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> > Convert enum->pointer for data in match data table, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> > bus type match support added to it.
> >
> > Add struct sx931x_info and replace enum->sx931x_info in the match table
> > and simplify sx9310_check_whoami().
>
> +CC Gwendal,
>
> I've applied this but note there is a comment inline + there is still plenty
> of time for others to comment before I push this out as non rebasing.
>
> Thanks,
>
> Jonathan
>
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
