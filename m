Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6120C1DA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgF0NoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 09:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0NoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 09:44:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E060E21655;
        Sat, 27 Jun 2020 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593265444;
        bh=zNHHbv8yZG7Tr/13VLMjcj16QvLBa4eunXcfuBB0iI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SngmTcfUOfo9kUTKtkZ3J4MycHrDGJ5ImkJB9EBQ1IrspYuPSHyFVfzkJ3On5wm2v
         cN8vJFfFXl+/+5eNmJNgyeZE06A6wTAqihdNYv9CEHKUIEpP0B7rZk9c82D5a8eTHV
         SpLGbuzqidSTTuAGnUL39HkoyzQO5VkbhWlQW7a8=
Date:   Sat, 27 Jun 2020 14:43:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: bmc150_magn: Document and fix
 missing compatibles
Message-ID: <20200627144359.1ae30bb0@archlinux>
In-Reply-To: <20200622060110.23192-1-krzk@kernel.org>
References: <20200622060110.23192-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jun 2020 08:01:09 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The driver supports also BMC156B and BMM150B but these compatibles had
> redundant suffix "_magn".  Add existing compatibles marking them
> deprecated along with adding a new, proper one for this family of
> devices.
Thanks for tidying this up.

The BMC156B is a dual magnetometer and accelerometer chip
so for that one the _magn postfix probably is needed.

Or am I missing something?

The way this does SPI is rather odd but seems to be the same as the bmc150
(two chips with non overlapping register maps).

Jonathan

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Mark old compatibles as deprecated, add new one.
> ---
>  .../devicetree/bindings/iio/magnetometer/bmc150_magn.txt    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> index fd5fca90fb39..efeda055be6a 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
> @@ -4,7 +4,11 @@ http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS00
>  
>  Required properties:
>  
> -  - compatible : should be "bosch,bmc150_magn"
> +  - compatible : should be one of:
> +                 "bosch,bmc150_magn"
> +                 "bosch,bmc156"
> +                 "bosch,bmc156_magn" (DEPRECATED, use bosch,bmc156)
> +                 "bosch,bmm150_magn" (DEPRECATED, use bosch,bmc156)
>    - reg : the I2C address of the magnetometer
>  
>  Optional properties:

