Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0655EA91B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiIZOyU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiIZOxs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 10:53:48 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54454855AA
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 06:20:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j188so8274874oih.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mAY1HEVtk4hYJP7zW/qM/bd6TsWaA40zZdUpMQkzXqE=;
        b=hqEueWwlUT+kzchmO/3VxS4vParWb6/nvzIeANFBpRchgS5/OP4tJCJcdpQ58iprYM
         D7sR04nVPSB2DowAGGurSCcTC2SSql9Yeway5IZ7cXPBg/qq10uwr4g+d+rRw3txLMhh
         CXimsoRG3KHJDa/WC90Chy69KAhPlDm/YFrs9ASSrTALzNPaSSDbkTZMt2sR4BFA/nla
         O8SyLtilMhRAfSLQLTPK+YTzMtMLgvso2NShLjJat/HPGNtaOZw6b/XCqXi+SsvZ77CO
         Fp17HUiIiiP5a1l4aWdVz5qQxAGQ0ceIuR2koKlqiZuLtNz2RkGgBC9N+wpxVI9/N44x
         DN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mAY1HEVtk4hYJP7zW/qM/bd6TsWaA40zZdUpMQkzXqE=;
        b=H7Aryttx4hVdnh98iH4QZgGGC6D+Pf3i4W1O6gfoxYEW9kt70GXwPBfZun2MFWC+87
         OsUexh6TADzPpwOj/hDt8DV8UNgBeIMSpAM0hq8OD/NnGTV96l8nhJyK1tuk/O3aHPmq
         PDRZnnpcllUpfkBxqFA7NpbJLW2zV6751L1YWm+bmnjUVdFWHMPf4dbWUZvxKv1E/U2C
         H/hCxZxlJ5jOJw1Ri9L3uk59IPMIJfSCyvCANJ4T02mj7H09CAmLjaRRfs2bx9f8/7LN
         57B2Ub/F2gPCSbegziFzMZcPvo9j+eDMRJKpVm2N/fdfHwCfaEFVs4C71qHIT9s9xZOz
         +FJg==
X-Gm-Message-State: ACrzQf3gfPC6jF3q1ZqawUc4+mLzPagXJ4syG+rwIZrP49jzXq3keOUp
        ILp3AFYjUUsOy3bqs2cKk4cTSX6hZHj/af61jTWt/Q==
X-Google-Smtp-Source: AMsMyM5pXxFe5svN75z3vvYCnuN6P2zxDJ0u2l1jldJt7KqcymPCEP6m0R7FBZamUAavb6QFKOdLykPlxNYT2XLkmIA=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr14929616oil.7.1664198452336; Mon, 26
 Sep 2022 06:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1663834141.git.cmo@melexis.com> <20220924173221.1174608b@jic23-huawei>
In-Reply-To: <20220924173221.1174608b@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 26 Sep 2022 15:20:16 +0200
Message-ID: <CAKv63utk0r+PJXkkY3PpAmKp3WT6H5GxnBLdtJm28W1kz01E+g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iio: temperature: mlx90632: Add powermanagement
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Sept 2022 at 18:32, Jonathan Cameron <jic23@kernel.org> wrote:
>
> > The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
> > hardcoded to 3 times as much as MEAS_MAX_TIME.
> >
> Hi Crt,
>
> Applied. However, we are cutting it very tight for the coming merge window
> so I'm not sure I'll get a 3rd pull request out (this just missed the 2nd
> one as I only queued up material that was in a final state last weekend)
> So for now pushed out as testing and we'll see if Linus hints at an rc8
> when he releases rc7 tomorrow.  If not this will be 6.2 material now.
>
I sure hope you mean 6.1 material... It would be great to get into 6.0
as i think that is a most likely candidate also for Android kernel
baseline (which is what I am also targeting).

> Thanks,
>
> Jonathan
>
>
