Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCB712530
	for <lists+linux-iio@lfdr.de>; Fri, 26 May 2023 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjEZLDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 May 2023 07:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEZLD3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 May 2023 07:03:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC2713A
        for <linux-iio@vger.kernel.org>; Fri, 26 May 2023 04:03:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so137683a12.0
        for <linux-iio@vger.kernel.org>; Fri, 26 May 2023 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685099006; x=1687691006;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=Jkvx8UA3wu91f5IQ0TPL51rHJCCvvgdZVLxKxkeQMs1MVlhk4gNMiSwVMImZku6YSy
         ya8jUf8pmJluaUm1G/U6gQ3e8r9td35vSWgir4Q4lplZAu8lmqiTzs3Z0NubspxVIKw2
         56H30WEZWIRtBYlm8L+Xn6nnniNiENTm7H0Nh574n7EHhH68nfCqDhutmPOsS7C1y0aX
         uy1zKiT4yMvkKONkV/cp/qTmgCHy9Qapn0ncxyBI1f5an+q0BD5gRItYP83Mj1ubmgfP
         L6+4RObhxX6LFrcxhSbab+nkI1l1W7BD2mHZ4+KqBtW2dywC37Inp7Aomev3dJnoYLWb
         +VIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685099006; x=1687691006;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+f0WP/+N5MvUYe92/BSqybSsARXcqQ8M6AlwJr5eQc=;
        b=WrcPQvxMEow0tS5wfueOueOAPHMydPEJvSBsOqoM29StBiYxEBnBn6GyyKdFZsrY/2
         e4sxDl3DkCEEBF+OpZAR/3CfbC74KB6GvXyrvMl4XYqpRaF53g2FUWlYG5lGUh54StEc
         nBACZnx6RThEWS4R3VEvq8M6C0YHDUtTaeuwTDPQuFW9Bb3/DmquqszgJS/S5Wm7JB7O
         c/li9kgqtIeSHoglR1P7ZRVofd2hdexEhms/EYmy/VkkY12/kYeAoREjgZeqEX9Nuaur
         l7NDEIDf0qr9QrRCFu3Z9GVmhbPDhGFgPOEPZNlW+UToX6tCwKDfCk7e7tg6spUpfrAb
         xaTQ==
X-Gm-Message-State: AC+VfDzWWOuIL8ABWR2LMG9l3MLlrypntvh7e1HG8zBXKFQae4jaoDRd
        MLRWNZAAsQ3Ntc+J23Qef6mpr0YuLB4whE4y4iY=
X-Google-Smtp-Source: ACHHUZ6kGeFx1kF+KMC3dEfnzyDwEPnBc2ocouMTZvYU8raANKFEKqRrfHk/8GELVqXsKdUVmoKdAQSgHT4LP1vcvZg=
X-Received: by 2002:aa7:dccd:0:b0:50d:f9b1:6918 with SMTP id
 w13-20020aa7dccd000000b0050df9b16918mr1008425edu.9.1685099006487; Fri, 26 May
 2023 04:03:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a872:0:b0:215:8936:d3be with HTTP; Fri, 26 May 2023
 04:03:26 -0700 (PDT)
Reply-To: laurabr8@outlook.com
From:   Laura Brown <jeswa7m@gmail.com>
Date:   Fri, 26 May 2023 11:03:26 +0000
Message-ID: <CACGCBD6MOyZ+cKJHcqX3N9gQTwwdRpZe4N78kRLSCxF8ogF1dg@mail.gmail.com>
Subject: =?UTF-8?B?15nXldedINeY15XXkQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

15nXldedINeY15XXkQ0KDQrXkNeg15kg15zXldeo15Qg15HXqNeQ15XXnywg15nXpteo16rXmSDX
kNeZ16rXmiDXp9ep16gg15HXoNeV15LXoiDXnNei15nXlteR15XXnyDXlNen16jXnyDXlNee16DX
ldeXINep15wg15Mi16gg15HXqNeQ15XXnw0K16nXnCA4LjUg157Xmdec15nXldefINeT15XXnNeo
INep15nXldeX15bXqCDXnNeX16nXkdeV16DXmi4g15nXqteo15Qg157XlteQ16osINeR16LXoden
15Qg15bXlSDXkNeg15kg16jXldem15Qg16nXqtep15nXkdeVDQrXkdeh15XXk9eZ15XXqi4NCg0K
15zXldeo15Qg15HXqNeQ15XXnw0K
