Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518D4E3946
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 08:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiCVHA4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiCVHAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 03:00:47 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC4C67
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:59:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-de48295467so923050fac.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=xV0QECCFZ5WC6u+4SCFy3qYe7DHsXjO2DEi/gGA/SSc=;
        b=Kc/fbkN1ROAwwEXlCEIapGFSl5+e1BS75Gcai1WJHDC1nywNbUniEKD+tBWO5FuaKe
         6K/rW6k3k1YoRC3NZ+OAk+xDYoE9/swUkpyw4RrlUJsEoz8o1FVhf59VT/QDQvxO9zPI
         Tyx1LTqXbp723PgIkc7NNdfqYQkTFru3WgZtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=xV0QECCFZ5WC6u+4SCFy3qYe7DHsXjO2DEi/gGA/SSc=;
        b=GQwvVWSV7GvOMPjlo2yQMPoQ/5/tHmQCglplZl/neA4AKpAEsMM+zdlwH2WQkYMMgV
         oSoHIJj10VddiyXqgEuZpLnA3AO2XsB3tVICWaWFkttcuur2ocVLzawb7Wpv1HJZZVY2
         Ui3u63Ryt3kMpSye+gQdNdYwtt2p7MeprtjoAbfjacPxrm+Ry/iwsaJZDnoWQyAsSR2M
         tiJMFM+ci4Y6KvE8MBJM3repgKXyfgb8RDQ/1MrX2NRHDOwDX+2q8dORb/VWB3Zf0vok
         zfDshsFpg0igw4nojHXGahipaKmJMDBqEkYdLJb+mqUy7qTpPfsECVwumQALjhma5/GB
         lfPA==
X-Gm-Message-State: AOAM530ZHqMQvDXxIxO+Mxe8brtjJGrg57nxP7Z/BnmuFv3ensX3/g43
        S5AF3EOMOeNi0tA7M3Pi/IpbVdBOXZv2toJJ30BJoVpgypE=
X-Google-Smtp-Source: ABdhPJwbFSsOuDP0KmHBRf7uS5Gn7BT9zwxqElRYqXJWmlWsG/eTB4RzxgWIqmKd8ssyOMVs4lBoMbhclP2ePAZ70Ps=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr966099oab.193.1647932359115; Mon, 21
 Mar 2022 23:59:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 07:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <20220322062504.1019504-6-gwendal@chromium.org>
References: <20220322062504.1019504-1-gwendal@chromium.org> <20220322062504.1019504-6-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Mar 2022 07:59:18 +0100
Message-ID: <CAE-0n53YaBBKgEDAd1A0nHHacVeE8iK7jOuxtPqAvhSUsKDU0w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: sx9324: Add internal
 compensation resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-21 23:25:01)
> Allow setting the internal resistor used for compensation.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v1:
> - Suffix field with kOhms unit.

That's not done here though. I guess there aren't any units.

>
>  .../bindings/iio/proximity/semtech,sx9324.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index 8fbea71823e76..b5f59038f9dd7 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,15 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>
> +  semtech,int-comp-resistor:
> +    description:
> +      Internal resistor setting for compensation.
> +    enum:
> +      - lowest
> +      - low
> +      - high
> +      - highest
> +
>    semtech,input-precharge-resistor-kohms:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 4
> @@ -165,6 +174,7 @@ examples:
>          semtech,ph01-proxraw-strength = <2>;
>          semtech,ph23-proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,int-comp-resistor = "lowest";
>          semtech,input-precharge-resistor-kohms = <2>;
>        };
>      };
> --
> 2.35.1.894.gb6a874cedc-goog
>
