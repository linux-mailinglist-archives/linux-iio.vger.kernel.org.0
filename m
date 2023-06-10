Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7B72AAC8
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jun 2023 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjFJKD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jun 2023 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJKD6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jun 2023 06:03:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7230D2
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 03:03:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3f735bfcbbbso18763985e9.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Jun 2023 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686391436; x=1688983436;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvKsWt9LONNBbmyn76CUaIRFpx6XrGejj9uupqUqu0c=;
        b=bYClprQpRDicTUk4vocRDMqbCH9gj8RbB4N2DvUTKqoOuVc2UZj+pu9MwcwEmJ2LWw
         u3j6QBX2uJCOq3eCmnFEWHVTNuiQaF5gayNs5aHdDU61+hnIJvn+k+YVlC1163hudwwg
         TcW2pYKYFrK0+F/qqrHuSyp5Ohhw8tbRtNbRYocDIXyaytmBVgNrbNeZl2XhBeDibwMB
         gS+8LK2R+i8PCiIJj3P3NBkQl12Pg2szk3R5nugUR6kPjCLQcGXwgaV83ku6EpSeHWNZ
         E0U/u3cuMd0lMgT50MddHuZhdAM6pLJKu1cotZ1myfdjWUEAtpCMosaXXK518JGJa1+M
         UJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686391436; x=1688983436;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvKsWt9LONNBbmyn76CUaIRFpx6XrGejj9uupqUqu0c=;
        b=FYD2dTQKE1OYVRJuCseHWv3Wr+nUa4o3rtAbj856TyknrqTeMvOt9JQe7YnUH/VpDJ
         dG5fSxPwg1BFRE+RL/08ELBjE7SkzlqVunBPJSAWqg93nc7GhvgCwuCBqbfQ5ZfcnYOC
         KwTGxuwEKg1HvpfokrJkwwNfxHYqNYCLCNMFlbrdo23tPAODgZYimx+r/4L6H5mbTUax
         lAbBVq4e5J1RbcVALFrzTZL/VQx4OS62fS89FdvtTjEcau6Oc7HROf1gaVOkLqrpBJuc
         biY8jnhditQpEqynBQP1dvUPouzDzeumOQjqMye0COk8MDW2TtF8rLWVTw2MWHMTcvDl
         l3eg==
X-Gm-Message-State: AC+VfDxCqTX6a4Z3sF5RRvidSOyVsjsJjTItdksbZFP1P00xCFpRpRJB
        fb8TzJ5JACZwnB40wgVeHyqKnFhQvzeg/UcFnP0=
X-Google-Smtp-Source: ACHHUZ4esFF9JNppY/Ko1tyQmxlGu6rMgTtnkFA24M0/Z4bEgaj9mfoWyLz6MGNLE2ZCEA6JGO9BrL7UsY17uthrp6E=
X-Received: by 2002:a05:600c:cd:b0:3f7:e7a0:967c with SMTP id
 u13-20020a05600c00cd00b003f7e7a0967cmr2352757wmm.19.1686391435922; Sat, 10
 Jun 2023 03:03:55 -0700 (PDT)
MIME-Version: 1.0
Sender: zaniidia2@gmail.com
Received: by 2002:a05:6020:7011:b0:279:8c3b:9389 with HTTP; Sat, 10 Jun 2023
 03:03:55 -0700 (PDT)
From:   Vasylina Matviyko <vasylinamatviyko@gmail.com>
Date:   Sat, 10 Jun 2023 12:03:55 +0200
X-Google-Sender-Auth: -rcUq25FGwEypQjK6enJYRH-4Mk
Message-ID: <CAJR8GoXK_NYPqkqEeR8PjhG_kPgE5=5uNe_q5gjkhSDs0yPdZg@mail.gmail.com>
Subject: Is this email still active
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
I haven't gotten a reply from u after my last email
