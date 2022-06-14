Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70E54B5C4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiFNQPm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357144AbiFNQNx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 12:13:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70937A97;
        Tue, 14 Jun 2022 09:13:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg6so18268389ejb.0;
        Tue, 14 Jun 2022 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmWPRm4CQytOjJbY5e6x4bG2uF7mqlwaQ9khfyHpdtM=;
        b=ar119iB/7OKDS7S6TQ4H4zTIo7J5STokKztBQLNQISaOQBcTFVUenE3VawcmlhRM0Q
         tOdaoTkWuP8lWLUSYLgbKAraMJ/O3CNkqxY7wSODmK/eSiUEgq78xoNM7V1YHkGON0Qy
         6qc7+5e+9LbsaoWLgyZOqpiFYoBk45HqLTyOGGDjnRUie/5myw9BChqtcHt7SabuKztj
         7EvGEsdnvMeDz+LhLqJ5aNkMbeJX2+V4iFcQ29SFdamIeQr09i5cMVZoQ1A7W6E67S8Z
         IY2TP5HgJf/9j27Dw17xc/abIefWL0120Cq1WdGpGmB/aonYAkgPj+Op/F1LVNVii511
         DlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmWPRm4CQytOjJbY5e6x4bG2uF7mqlwaQ9khfyHpdtM=;
        b=THV7N0sL81gSNpoAZT6b7xvLfK2gu36131sf5eu7MwKVANRKtXy8D/ybPZdr/5BOag
         MvtYEDC7pMTAFkJ+hTsFJqqchvHoK4tZs1ZFv2y7rInCaZ+zR7+zo9Db0vT6XReBxVm8
         7wFEsK1cx0uCP7RKUV+i1f04VFQd4r1HSKyv0nnXV7iSRysHzgM5+nLcfmmYSX46EcWV
         clDTgDE5bUXCqdkb9kAwrPAHRy+O4YkIMCeD0NloAm/cK5T/e6f/9jyos3lI7Ed2O/lc
         3M67WbiqNIdhr8U75XszTLhvTJZgXsfD0xQEfKUsx55qZz4YZPDT5injfjRrfMe5r2IV
         YkxQ==
X-Gm-Message-State: AOAM532t8uknzKnF12+xtqiBRVJe3MQWIO9xFZgioi1c+Pr0VobMX9HL
        aYsMIfjfCy5EwU0EopzgeA4/lKbEB/nE0TYg9KM=
X-Google-Smtp-Source: AGRyM1tlfdJQTGTYe1hRWfpb3xnCIKhQnrHGUlC5N6lBZ8nqyM+sV2xgWwsK9lMjbwTNVLs2zg4VHXT5WcxogDWDFoQ=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr4969164ejc.579.1655223231098; Tue, 14
 Jun 2022 09:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220614151722.2194936-1-sravanhome@gmail.com> <20220614151722.2194936-6-sravanhome@gmail.com>
In-Reply-To: <20220614151722.2194936-6-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 18:13:09 +0200
Message-ID: <CAHp75Ve1FygZOUfbXkhu5jkpKmiVPxAcxUNaP31LHLWfL-pZzQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] power: supply: mp2629: Add usb fast charge settings
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 14, 2022 at 5:17 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Allows the user to change the usb device fast charge setting to advertise
> host on enumeration helps to accelerate the charging cycle. Altering this
> value resets usb existing connection.

USB

...

> +KernelVersion: 5.19

I don't think it will be available at v5.19. v5.20?

-- 
With Best Regards,
Andy Shevchenko
