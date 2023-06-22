Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883873951C
	for <lists+linux-iio@lfdr.de>; Thu, 22 Jun 2023 04:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFVCEo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jun 2023 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVCEn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2023 22:04:43 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0121B2;
        Wed, 21 Jun 2023 19:04:42 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77e43ec5e0eso144228839f.3;
        Wed, 21 Jun 2023 19:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687399482; x=1689991482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8pPKLg70fficersjkVy7mRZC504grE7nwpNa/9wr48=;
        b=Xtd81PJ7CXeb7gWiTZEM7K9yV+XRNA1al1FmH1P/TVwClNKqqroDm3CohEOuQzGaoo
         oNVKIf5R6YxpvM4t4ooBE9A/v6bDEMEYBv13I/GF1J3Ae7FqDzHOVwOPLAbuyebZAhxg
         J33FrzGRMzfBf1vpdyfqrCOnOGrSYRbcWt5nDjN9fJJnvyhFdBZfOKpDX/+XgCVweAam
         PaJrW10FC8J6qJOPrEmMu9kqsJLwJ4N2HdK7Mis/y4fH1bTAzy3v2qM8sRHdomtQUwnf
         1XpV8KOI0wltsBz8i/IXtr/RHhpSHahlnqFTcsP/2AvVuro+cFhVuqgpotBYbRoGzL2C
         G88w==
X-Gm-Message-State: AC+VfDx/thdjBCactGEgIS/RCaqBTiEpO6+UMeQ5oLleEqI++Mv2VShH
        LXeN7D1JjEshF/xvwA4skQ==
X-Google-Smtp-Source: ACHHUZ41feipjCJIdWq0RZgRL7fxauSaOQuwv40KYo0fwQYG90tPDjI+19MP3M/e9J1d9Fed2Az6yA==
X-Received: by 2002:a05:6602:19:b0:77b:865:5532 with SMTP id b25-20020a056602001900b0077b08655532mr15701573ioa.12.1687399482114;
        Wed, 21 Jun 2023 19:04:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a02a304000000b00428857e6213sm276575jai.82.2023.06.21.19.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:04:41 -0700 (PDT)
Received: (nullmailer pid 63635 invoked by uid 1000);
        Thu, 22 Jun 2023 02:04:39 -0000
Date:   Wed, 21 Jun 2023 20:04:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alazar@startmail.com,
        kernel@pengutronix.de, linux-iio@vger.kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, conor+dt@kernel.org, jic23@kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <168739947869.63465.3640581768539136376.robh@kernel.org>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621160857.3400747-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Wed, 21 Jun 2023 18:08:57 +0200, Marco Felsch wrote:
> Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> allowed for all devices but only for the ADS1115 devices a value of 7
> does make a difference.
> 
> While on it fix the description of the datarate for ADS1115 devices as
> well.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

