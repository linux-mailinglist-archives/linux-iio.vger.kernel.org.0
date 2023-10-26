Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3EB7D819C
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjJZLO4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJZLOz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 07:14:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D21AD;
        Thu, 26 Oct 2023 04:14:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso703475b3a.1;
        Thu, 26 Oct 2023 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698318892; x=1698923692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EkearvrdceNuYTs2jdkNmK1OqvyMKYioDUn4ZJUv9Nk=;
        b=KZShzUZkIucmyFKKWnslILNHlDYFh97RBkmV9oMyrz7QJaW1QABjbrEqU/2wrBxhAI
         K0HW9qEze7VzCSQ5QKESKeCLwW4HX+Fot5gnAHs8gGym7afUYkvQ66ztFoHlJsqt7c4E
         c1wnVVwts85f+z3jFI396d/JXVn8XAFsHveMpSHJaLM2IPntefVXbTaze596ZTr4aZXd
         /hhspFDOCtrINoB2lKks4+A42OalzrpvMRVRDchQubuQpGL8qBUPowdBi3FuxZSEp7e3
         WnN1AED+MGAcNunVA4/pe9XBbbX2bb14zVysDlBvMF+tO3gCbiGIKfaIrqRJbj14TGO+
         7Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318892; x=1698923692;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkearvrdceNuYTs2jdkNmK1OqvyMKYioDUn4ZJUv9Nk=;
        b=U9gBPjP89aAj0VoUwopDFJ7ukJ9kqZMkDkwWJA/pQuvGMN/EncbAp7tCRgfmJVNucS
         Esc3PyFS4EAMn0ZuFISdJ86vybdKwawiapbMzHWhx5Smn4ifAJhiHuwp/PVzGDlJkGIO
         pikvnZAqQ1DDaWuz5yDsrWZPYWJBXHQ9Sqjy5YDnwXDx7U7Trovdfuy61gSf7zN4NTsH
         CJpiyp31pqNtqFuivJLw6Gp+C/AAzEQABA6JCuXiq9SWxozshVE2ip1cGoyU7t9zEqln
         iYuphU8NPYeAHe9UweRXWwa711/EPa5+X/a4ZCeK5WtbnpznoNTR9wvHdYvXFvCdIwVm
         t9uw==
X-Gm-Message-State: AOJu0Yz/cPMYVJO9eta5yK0L4njUEd+D72XkZxBkYb8lJiIjxTFfv1s6
        oQEVby2HWrOP66NrEKEdAxPYfgN7kFETDoSJGwY=
X-Google-Smtp-Source: AGHT+IEdE0vafWyL5tlJ0mChrmln8wjHb6yEqAzZSnUzsNcWUD2fWcDu5bu1z74PKXPGhM2Oi1UX9xNmKNSTpiueXf4=
X-Received: by 2002:a05:6a21:7985:b0:16b:afc2:3b69 with SMTP id
 bh5-20020a056a21798500b0016bafc23b69mr7327323pzc.36.1698318892351; Thu, 26
 Oct 2023 04:14:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Oct 2023 04:14:51 -0700
From:   Amit Dhingra <mechanicalamit@gmail.com>
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
 <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com> <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
 <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
Date:   Thu, 26 Oct 2023 04:14:51 -0700
Message-ID: <CAO=gReGCris01BoeZuBK730uRZJr+rOOWVE+bPaMRp_BKQ7siw@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: correct file entry IIO LIGHT SENSOR
 GAIN-TIME_SCALE HELPERS
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 26, 2023 at 03:15:13AM -0700, Amit Dhingra wrote:
> index a493d96ffd85..6dd44ec48886 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10287,8 +10287,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS

v1 and v2 were mistakenly based on linux-next. v3 is based on v6.6-rc7.
Apologies.

>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	drivers/iio/light/gain-time-scale-helper.c
> -F:	drivers/iio/light/gain-time-scale-helper.h
> +F:	drivers/iio/industrialio-gts-helper.c
> +F:	include/linux/iio/iio-gts-helper.h
>
>  IIO MULTIPLEXER
>  M:	Peter Rosin <peda@axentia.se>
> --
> 2.42.0
