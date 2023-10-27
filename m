Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07697D9AAB
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 16:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbjJ0OCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0OCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 10:02:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D5C0
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 07:02:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC30AC433C7;
        Fri, 27 Oct 2023 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415358;
        bh=uxMVYafoD0kHgKfOSPj18Gk0qoRCj9fYkbmoIUBeQ7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bapCnaApUObQaRoQPNOONV6jMj8QvVCpfd2UChLNIageObQvTWbNL+TJWZ+bSXoWg
         Ia+kpkXxdVI5FWqkGRyLpFJZWaaF99Uf/XSdKL6t/tyrgA9Q9b5DxolXKZ4S1DbnKN
         q7Q2MxtWqqMXADJFubEVhYMeTwMKufIWK2We/BfV6pCbQEMRrFHDOeRMgVUMXk6qhK
         QUN0x2N9rNJI4J+ujgU1Y56e2HSSStmZD56gkE3TYhwyyvaU+z7bQtdDNVabkWFtqR
         G3zOfLAXda8684ayNqCLA3beNg5031FeseAZQqC/nxJxEiZ7fdgInQ19F7PO+G22Wg
         eSl+cb04otPbw==
Date:   Fri, 27 Oct 2023 15:02:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] dt-bindings: iio: pressure: bmp085: Update links about
 sensor specifications
Message-ID: <20231027150222.6b41f023@jic23-huawei>
In-Reply-To: <20231023080237.218179-1-579lpy@gmail.com>
References: <20231023080237.218179-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Oct 2023 16:02:37 +0800
Li peiyu <579lpy@gmail.com> wrote:

> The link to the device specifications in bmp085.yaml is no longer valid
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>

As this is touching a device tree binding, it needs to be cc'd to the
device tree list and the maintainers.

Otherwise they won't review it.  I doubt they will care much about this one
but we should still aim to follow procedure consistently.

Please resend with the CCs added.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/pressure/bmp085.yaml       | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..5c77769c8200 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -13,11 +13,11 @@ description: |
>    Pressure, temperature and humidity iio sensors with i2c and spi interfaces
>  
>    Specifications about the sensor can be found at:
> -    https://www.bosch-sensortec.com/bst/products/all_products/bmp180
> -    https://www.bosch-sensortec.com/bst/products/all_products/bmp280
> -    https://www.bosch-sensortec.com/bst/products/all_products/bme280
> -    https://www.bosch-sensortec.com/bst/products/all_products/bmp380
> -    https://www.bosch-sensortec.com/bst/products/all_products/bmp580
> +    https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> +    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp280/
> +    https://www.bosch-sensortec.com/products/environmental-sensors/humidity-sensors-bme280/
> +    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp380/
> +    https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp580/
>  
>  properties:
>    compatible:

