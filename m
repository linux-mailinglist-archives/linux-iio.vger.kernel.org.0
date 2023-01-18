Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24341672D08
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 00:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjARXzH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 18:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjARXyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 18:54:46 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E24994F
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 15:54:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y18so411155ljk.11
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 15:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYrMw3/IeRv7TW4QNk3zPlYQuNPsIe7wUOKS4NjkGS0=;
        b=K8ly6emFAqGAA22x+q/ZurAWisaHh8ge1KHBvgTXbS3+VO5TodHzfuaZAz2yZVyZj0
         L7gQzLkhRsdIsGO0Mn/qUpNM97shSrEW95jmIs6sPh9Zkq1R5txo14E/h6Km7O881z1O
         i+U4b/uG5kopa+ud+gsH4l3p3FziOwFd+qoJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYrMw3/IeRv7TW4QNk3zPlYQuNPsIe7wUOKS4NjkGS0=;
        b=H/EUV5drHpIWv/u7iTV+1O2WC6/d2PQIYQhpJ4O3tPB7fbXogGRii2OgvyGurZ/iz7
         0I5HczHCDeItQzGiEmW/tQA0XAunNaN0xW9SREuYsvL0QfDmJC6AXGBUxa7EccWP5MR8
         6AqBA9mBdwksqxtkzTGnoyNpRSMcFvQq81Sz3a/Qe74/5jEYPGsqgGZFABSiAT021Urc
         iS535ugJWsz2LJSouVkDMPLUKEwMlYcdCg4v/re5p6AQh9aTZiA7yYnyChIarXnzZ0k1
         bq92OPQiQ602US4YFWPYvGTQxHdh0xIM4j5rVBSarXevFxx9UDyZlRLmZIpit5EcGRuX
         cHqQ==
X-Gm-Message-State: AFqh2koFdFMc0hE43QncPTC+K5vZqS3tMlHvkltVZGUDk43cmbMgJpj+
        fwbrQuZROx5CohFrHJ18DIK0m3bAQNRftY3/Ssj/Lg==
X-Google-Smtp-Source: AMrXdXtV9/EvY88izpZDNRGb0mcJzG9wCFMUrHPHXuEO8AGVgoLTo9c70QaJmh6rbOpnQub3UHpAkLYKcR6/wa70gaU=
X-Received: by 2002:a2e:a49a:0:b0:28b:6abf:29ea with SMTP id
 h26-20020a2ea49a000000b0028b6abf29eamr780014lji.359.1674086069412; Wed, 18
 Jan 2023 15:54:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Jan 2023 17:54:28 -0600
MIME-Version: 1.0
In-Reply-To: <20230114172928.80414-1-jic23@kernel.org>
References: <20230114172928.80414-1-jic23@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 Jan 2023 17:54:28 -0600
Message-ID: <CAE-0n502JpQWfZsN960KcA34ndrqMmkmznCNGY36eGJ=JPiy3g@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx_common: Drop documentation of non
 existent struct element.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Jonathan Cameron (2023-01-14 09:29:28)
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> struct sx_common_data doesn't have a num_default_regs element so
> drop the documentation for it.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
