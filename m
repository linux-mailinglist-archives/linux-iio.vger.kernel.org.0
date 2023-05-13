Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7992701941
	for <lists+linux-iio@lfdr.de>; Sat, 13 May 2023 20:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjEMSf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 May 2023 14:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMSfz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 May 2023 14:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BF1FDA;
        Sat, 13 May 2023 11:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A04261D73;
        Sat, 13 May 2023 18:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F321DC433EF;
        Sat, 13 May 2023 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684002953;
        bh=aE6/G/mkb//NAFug7MlXvXjKE/9qdYbo/KUKaSfLiX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BWwxNNujZXEhmeJ+jNAqooMyDnIW3G851vzW4BT9kb6NiI7cmoYG0aguVFTeUJmH7
         drCDnpNMZ227iHZ/+rR+CgTWivXBv6eqFmn7kXHMJWFfGETVBF3/viNYaNF38Cjfkw
         kgjUT/qgyMUw6CgTCDSNYqPenzNjqi/E+vIUKcNU9i1nR5kzX1KEQ9dIe1kMb9+GC3
         1lU2zuKmEZlauYwbrO8JqkbHgOMSjSkJpBzqovQpf95jJY49zmodKyY/BZORUyLNMY
         8vRQCczdkJdRXWO31CEB3DB25qCjQ6WADfEm6cB2QESBxC6uo+oIO4wTdomke7U0cn
         2NKoakOYogdwA==
Date:   Sat, 13 May 2023 19:51:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix
 adi,ad7476 compatible value
Message-ID: <20230513195154.27ef5757@jic23-huawei>
In-Reply-To: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
References: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 May 2023 14:34:22 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The conversion to json-schema accidentally dropped the "ad" part prefix
> from the compatible value.
> 
> Fixes: 8c41245872e206ec ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
oops.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> index 1c7aee5ed3e0bfb2..36dff3250ea76fe5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
> @@ -90,7 +90,7 @@ patternProperties:
>              of the MAX chips to the GyroADC, while MISO line of each Maxim
>              ADC connects to a shared input pin of the GyroADC.
>          enum:
> -          - adi,7476
> +          - adi,ad7476
>            - fujitsu,mb88101a
>            - maxim,max1162
>            - maxim,max11100

