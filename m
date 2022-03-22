Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF84E3932
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 07:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiCVGw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237101AbiCVGw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 02:52:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D3CD2
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:51:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b188so18583523oia.13
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QrbBYOLA9ifSEP/uvpbhaqBxiOrq+G2Kyb2zf7z7ANs=;
        b=geYdgU0DJ/v5LE7OmyCm/f0ayfPQX8kbx7A3QKvBHlqm/D+guTGxs1yvTyMuq9WdSL
         WHsmW7hW32i1gSk0kaWqGvcZlpSCygyOeqKKQD5gEA4Xqc41+2Qlp7fA95XwZ6ttRSbT
         xXDv3U/lWtuiIX4XyujAgsmxeLl/DsC9zFhiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QrbBYOLA9ifSEP/uvpbhaqBxiOrq+G2Kyb2zf7z7ANs=;
        b=l9t+4Gsd8MPMM9ytHJ+2MlsVMstI15Gt0C/TdmW/+HR59sGEpoX/VPLvHMQB9Wpdpj
         lrWf6aXllnOR0INFTuKv4aAX+f6qJ8hLQIFwN5TuG8ZPHl56xU1DdHDdAqNHjHck3gMx
         x1eNjKNvruMUa3fmL+XpvjnPDeDpt/cQ8j4lL2pAoN789pSVeINDvcTb7+81uNre/vC9
         m9gTSbczfIk11bq8RKlMPgUAjPXiM9cPNsMRBM4HeGOxGlTkv6pOL1nM3IDUMB930wcA
         +sk50+t6fOvSF5aNaA2rwBq5KZ/qnDCDhwCRdjpYvhtz6eF2v53e39IskzoPiVgvoZ/6
         5Mtg==
X-Gm-Message-State: AOAM533b+7exa6N54mkkbISk5V8WbrLB7EMaFvffzktVtuy4UpOA2jDo
        8j/Fw0342xsCeWmoUFUYNXUzFyqEm07YNh9seXf3ng==
X-Google-Smtp-Source: ABdhPJwLY0Rbcvg23sepDbfePMByVRNH79Xehhp2Q5o8mywLFsuYHBi5FM1Rvr4oUqYcDMNs56OTbQjwEbZxmCgS6Ic=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr1254431oie.193.1647931860140; Mon, 21
 Mar 2022 23:51:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 07:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <20220322062504.1019504-3-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org> <20220322062504.1019504-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Mar 2022 07:50:59 +0100
Message-ID: <CAE-0n52LLdYf7ZHVZ1JU2xjzCX2RbMacRWbxa02i7jOp=C95_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] iio: sx9324: Fix register field spelling
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-21 23:24:58)
> Field for PROX_CTRL4 should contain PROX_CTRL4.
>
> Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
