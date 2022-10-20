Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C96056DE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Oct 2022 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJTFkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Oct 2022 01:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJTFki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 01:40:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DE1111B87
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2022 22:40:33 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a18so12209640qko.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2022 22:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QFPLOCgmcy6ZgKOtMIFSae1/Gx1kuVTF92eXWAYt6l8=;
        b=TvuIiVJEmiI/0aa9367e6AYoUC6780RPkCahkekJ2I63oGbmson6Er+ljgGu4G7RFm
         Jk3g7Lqpf3wa2w1ZnT8sDyeYZ0Nrl1pY1SQaxjyCvpn5Ox25biyAt95hgSxoVGO8arDY
         8UbUqmrW99sPC8xqmcgvr1UyOQyzCMA8sn/sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFPLOCgmcy6ZgKOtMIFSae1/Gx1kuVTF92eXWAYt6l8=;
        b=WCANZOoYRb3tRuBZNc6lGTbfiN21zJZ463tfDTOKIyE3x+ASrKX4OMXhxUquBwt3NA
         182hybSBYNJhYxrpqbp43WWBPUHdyNK+Te+Ri8wmAKy8AFG7GRbkuoBHn9rxjT3ZLbr1
         e2bfRlTQnJ2vviPNR2DjcCWpqNx88GZGyhklCoe0ym2BWYYGQTVyOTEU5tugBZb4ftUB
         YH1mtJhln9kgIEDDLLmWYgjY+ScAgv74s2gTt9/EP6JaT2Uwq17nHrmsDLbzrDrLfbJ9
         R8KkGCrg4krr80GuIbjRe/L1XzETlY4AW4rwqEebT9jmSzPsidNgmfUGFfvnTJo9XVvA
         ZH0A==
X-Gm-Message-State: ACrzQf0YhcVoXtx+7AIyh7Nf6Flhuv8BctJplFS5HnNm29K7IRA7rbeG
        2GTlQznOluDz1oqfbgB1OxC2Nhz7GTrR2RRB9ETpcg==
X-Google-Smtp-Source: AMsMyM6f6Nv3ES6euPImiQL+z+4qJPAXTxI01z1q7EBw2JmogTpwid8CQdfLvAcyNERnXzPIMlxg4n6S/ggN7ROWZB8=
X-Received: by 2002:a37:584:0:b0:6eb:b98:926b with SMTP id 126-20020a370584000000b006eb0b98926bmr8057637qkf.233.1666244432764;
 Wed, 19 Oct 2022 22:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221019125254.952588-1-mitja@lxnav.com> <20221019125254.952588-3-mitja@lxnav.com>
 <a44cadfe-5e9d-8c6a-b111-abd550a909bf@linaro.org>
In-Reply-To: <a44cadfe-5e9d-8c6a-b111-abd550a909bf@linaro.org>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Thu, 20 Oct 2022 07:40:06 +0200
Message-ID: <CACbQKWdyE2Q7wya4JwAv2+9-1M3oSrB3YfR+qfM3M7TiHjukew@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency
 setting to the example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 19, 2022 at 5:49 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Use subject prefixes matching the subsystem (git log --oneline -- ...).

Will do.

> Whether it is honored by driver it matters less. More important is how
> hardware can handle it. This should be included in the bindings/properties.

The hardware handles frequencies up to 20MHz. That constraint is already
written in meas,ms5611.yaml.
What my patch 2 does is allow the user to set a lower frequency and the patch
3 just emphasises that in the example.

Kind regards,
Mitja
