Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B6B53D7A9
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiFDQNI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQNH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:13:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C12F394;
        Sat,  4 Jun 2022 09:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC3DACE0936;
        Sat,  4 Jun 2022 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADBC385B8;
        Sat,  4 Jun 2022 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359182;
        bh=vuLeWNtZJ8RsRpXAB7Rrc+9w0KJ1ynv7URHUu1GrFaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWHEpGLSMYZm4ML1+ujdAiqCjikcJKyuNA/U4dqNEqeopv3TFMKDMcnmXQLMp8YZj
         nZl41da77RGNC/HfBAb1iM1OJvdI8eC7p0xmS9ZjbUpXiKAirsjO5MP9r3seJB7chh
         MS0RX6t8yCe9+XU2kBhEpRv7H7Mfv2sXYtjv3SRliV0Z+ptjYHEfvMybQkvWryyMzH
         JMVqTi6OVXjpBYgQyYgpV/7cxqvI//skBD0HxhaQ0pvrIG4uci6T0RfPvWS8J+0A8w
         fSoccZOvGOsdOG182dI/SKlJuUGhLVL77OzAl+0SaxmVn0onocb1+Obv7xABFi/Exb
         leyt0kDkMlfsw==
Date:   Sat, 4 Jun 2022 17:22:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 05/10] dt-bindings: iio: sx9324: Add internal
 compensation resistor setting
Message-ID: <20220604172203.506d69d2@jic23-huawei>
In-Reply-To: <20220429220144.1476049-6-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-6-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Apr 2022 15:01:39 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Allow setting the internal resistor used for compensation.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
Applied.
> ---
> Changes since v4:
> - no changes
> 
> Changes since v3:
> - Added Review tags.
> 
> Changes since v2:
> - no changes
> 
> Changes since v1:
> - no changes
> 
>  .../bindings/iio/proximity/semtech,sx9324.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index d689b2bab71b4..0be87ac05b97a 100644
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
>    semtech,input-precharge-resistor-ohms:
>      default: 4000
>      multipleOf: 2000
> @@ -165,6 +174,7 @@ examples:
>          semtech,ph01-proxraw-strength = <2>;
>          semtech,ph23-proxraw-strength = <2>;
>          semtech,avg-pos-strength = <64>;
> +        semtech,int-comp-resistor = "lowest";
>          semtech,input-precharge-resistor-ohms = <2000>;
>        };
>      };

