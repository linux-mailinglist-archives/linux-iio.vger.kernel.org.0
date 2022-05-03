Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D86518CE0
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiECTO1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbiECTOY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 15:14:24 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B33F8A6
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 12:10:49 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e93ff05b23so18119846fac.9
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Lqovqzyrj4FPxzelch4DRi6Pl2EqzvWsu8MI7U4iZa0=;
        b=f4qUVEfoOyzFhZf4oo3iRHKT59e3kQrHMPLGjPFxJwEn415fl+b6exqppPX60fm96w
         ojqVoEwWjN8Ns7JJ5j/NjsE9fq6/mtHlkovkJTPP7RyPHudyA3OKfUp/oHbv+moQhbIJ
         3mvsuc9iHWKxxu2J1bDaKGy8IgHjST0RbqKOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Lqovqzyrj4FPxzelch4DRi6Pl2EqzvWsu8MI7U4iZa0=;
        b=IEt6cejdblkKz3FpyG5IVbYEKg4WvEJ/13XLUShfD07+K4czsuf7LWgaRIAODZVrPG
         sy+FqV3XEMitvyKeOu61ForRPavOIwAqG89wrOP7X/0wMzpOmhi8gXCbTA6HZYjgqqS0
         5cbhKyPkGztl943AXhsIK/RhRYAXxEjjKAui/lWBLkoB01FYNbXszeZKiCrdtysrolGF
         Hh2bnrAEBj+p4VSJxCwvy5PB5Mhvx2HqiToXQ0JXFONWAOWiiZWNRhpFyYn+AN3PAUXj
         XjmALMfLBT2+gc6kQzXoamOqI6jW06lBLs6YT+/2SVgTsjGT/MQo1W3L6gCxO/h8FmbY
         OA+Q==
X-Gm-Message-State: AOAM530svnmqmdHPHdZ+hk2BDB/wmBrNBUqUX1wc/XljAmMlJlg07a/i
        Nm+aWevdT1NCfzyc5/9kU4YNxMCh0hvIuh4JWYp3Zg==
X-Google-Smtp-Source: ABdhPJyMNM8SO6j8B7hJfADgjT9GxhSYWURtNqrRY3Iuhd85Iu0eDnTtgsFnYceGWG+mpwAV8GXyjfLFJsrV1wXez7s=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr2268247oal.193.1651605049357; Tue, 03
 May 2022 12:10:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 May 2022 15:10:48 -0400
MIME-Version: 1.0
In-Reply-To: <20220429220144.1476049-8-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org> <20220429220144.1476049-8-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 3 May 2022 15:10:48 -0400
Message-ID: <CAE-0n509DaRxXu2dRd9kVfnd_J8P2A3w=9sdVZ7nx7g199bTCQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] dt-bindings: iio: sx9324: Add input analog gain
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-04-29 15:01:41)
> Allow setting the configure the input analog gain.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
