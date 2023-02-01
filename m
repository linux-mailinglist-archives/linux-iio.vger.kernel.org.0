Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8126862D0
	for <lists+linux-iio@lfdr.de>; Wed,  1 Feb 2023 10:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBAJaE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Feb 2023 04:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjBAJ37 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2023 04:29:59 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95B6187D
        for <linux-iio@vger.kernel.org>; Wed,  1 Feb 2023 01:29:58 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u72so21524654ybi.7
        for <linux-iio@vger.kernel.org>; Wed, 01 Feb 2023 01:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KhoolhMckxqWrv235zYZtPF4tzr8Frco5OS8VwOn2is=;
        b=pLY0/9QKC1kVar9Ri59+RLs67IzOAeA3gq5tohm8s5M07NOiKDT/bN959IoCB+WRLQ
         qzyuOfZ6Zdu/JMgc4CU5rhOTOhTdaqVOhfYWExYiqL6d/TtfP9fhDV2l4qcT/QTCt1U2
         q8ilAQFJ+hryST6wUIGJkASyf/G/mIBybt7XdF4oWfdLOSegF8M4itmpRfZIb5nwqdCF
         bly3vlAd5/LPMsoOLSuhxC0dRjATNTXsLa66qfMpHceIJ1y+QvRPlB8pmy/DZtEB2A75
         INNgAv9tFDJ/4e0dCV7hW3oCSB4y1GtG2QhvJH+Bwnfh4X6qqqBb9JTmEj5PlGEVHqNg
         vWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhoolhMckxqWrv235zYZtPF4tzr8Frco5OS8VwOn2is=;
        b=haVHbAtlyZEPBOCqRZbDHhtX06egEvL6wDSb5SXsXYJrLD02Itkb6gxKcDgjVOuLn5
         nLD0Uwt/l2n0EhsIKgG11Na1Xi5wcbYH5kvCVTg2013nWwoR1lSFl//BhjFCj5S1s5Dg
         BC8g8kF5+n1BlXlNNGpyOErJwVceLOPA8XV5RI32ZeTiu3ofmS5AXFrot1D7lkOZR2Z5
         QskdQrvrtzSCm/9gSeW31YpYuJHu/NTehk782IS5V7m640X8vjN8WLlm+Q/MF8jsamA5
         GR3t2o9e0b5z+EmvZYQM7GwHfvfGf+pagiOEuUbV5RSIZsE1L5+aLmjrLDkL4TYq5Lof
         dCtg==
X-Gm-Message-State: AO0yUKUV63gn35J1n/NuvRTlX3BXLlO1orxdKv5Qnptmv0XTM91aMh8L
        KsJOV664ijSpPcvZoqXv7jfQ7+pC7svwJnA2IgptWA==
X-Google-Smtp-Source: AK7set+tuVRLZ4AdP759wfl1fZTnbBKhFP0FPnAP3xxxUrZJxw2TvTMOScsMLNI+hFXGM9nye6SOMa0E7/3wCeDwUsc=
X-Received: by 2002:a25:910:0:b0:83e:bd63:6dd7 with SMTP id
 16-20020a250910000000b0083ebd636dd7mr227209ybj.24.1675243797830; Wed, 01 Feb
 2023 01:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20230123211758.563383-1-jic23@kernel.org> <20230123211758.563383-13-jic23@kernel.org>
 <6abc3265-75a2-1fa6-803e-6066a81b8ec5@linaro.org> <20230124094344.00003e67@Huawei.com>
In-Reply-To: <20230124094344.00003e67@Huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Feb 2023 10:29:46 +0100
Message-ID: <CACRpkdZrgLQsR-BkT-FG4HvJv3fvQ1ETRcaJYAXahOcM5mcYOw@mail.gmail.com>
Subject: Re: [PATCH 12/12] dt-bindings: iio: accel: Add ADIS16203 Inclinometer
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 24, 2023 at 10:43 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:

> > This won't work. It's an list. You need:
> > items:
> >   enum:
> >      .....
>
> Gah. I'm still rubbish at writing these things. I guess I just
> don't do them often enough.

No the dtschema YAML is just really hard. Don't beat yourself up about it.

Yours,
Linus Walleij
