Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD24EB5EA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 00:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiC2WbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Mar 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiC2WbY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2022 18:31:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5A68987
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 15:29:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso129774wme.5
        for <linux-iio@vger.kernel.org>; Tue, 29 Mar 2022 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=F+JLqqoyR4wko8jydlJ3TiMlSwuZ6gEaNIyb1WlX23R1qVYs8/xfk3XsZGW9n6kE2H
         EUIowL+y5Ngvd9RNj+ZfOckgF3Q3Ww9ra93HUay5yZb4di6BooHBbMJY/q//cKDkUsAf
         hX0u9pSpiBOmu79rc7VsPnnHxgyTUSQiDXqxPFgM8SeuupQFww2aw0H192xhGScePrs9
         mVcBQsiEu7hXYHPAByioT+G3Go6SUkREfFfktKqzJB1Kfc5RA9N1thjijBe8YyylaWir
         51uURzBCMuakQWhqB+1bFhyXSRpW9pWqgbAVALNh7rpBWqa2SjelIviw+7/xqmErfNjP
         eX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=zfM6n27kfbR2NO6WByYNlvE33t9DWtFivxVAbuZ1vKwS3zdDTnN1srkyPDSsiWzhC7
         PHxnmIVxGgby/Iy7AdPnCUP+aXGLWwX6+n/t2dhIezcFf0pubUs0ebyUEkDvThxVknT2
         C9Tif9+0vUTvwKbL0GPSRBljPl4z+PREmcL+CpcL3Ern5vgXhMSR0LKSJDbjO3QzPLZQ
         XZlKXnLSFGyhIQKv4CKlxtKdL0KyctZ75QL7VF0z6f1lj+FQlI65MwszrGNVgqnQd1v/
         TzRpie97TZL5m2Ive6GGkRuEfQDbtPrm6TLKPcJErqmYURmk+xYhQgInXlnoMiQqFAl2
         Twtg==
X-Gm-Message-State: AOAM530UAjLdtxfoG63BSqlAKVTTrgBfccBFrPuLOd6hd6fZ0yC5wlZi
        EcDJrMcBFaOY8XIq7eeDK28=
X-Google-Smtp-Source: ABdhPJz7qvut3D92JvlncuCOD3y+hQOQqfnz6SuOiqAPhwgfy15/7QfM+ewyeRtCiszYfIy2OpmTuw==
X-Received: by 2002:a1c:2946:0:b0:37b:d710:f565 with SMTP id p67-20020a1c2946000000b0037bd710f565mr1664073wmp.10.1648592979326;
        Tue, 29 Mar 2022 15:29:39 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.187])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d48d0000000b00205cf199abcsm2851970wrs.46.2022.03.29.15.29.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:37 -0700 (PDT)
Message-ID: <62438851.1c69fb81.a7286.bcd3@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:26 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
