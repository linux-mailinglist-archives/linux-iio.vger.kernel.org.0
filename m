Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4006844EB4D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhKLQ1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 11:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235355AbhKLQ1D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:27:03 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCDF61039;
        Fri, 12 Nov 2021 16:24:11 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:28:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: dt: iio: st_lsm6dsx: add
 disable-shub property
Message-ID: <20211112162847.782f806a@jic23-huawei>
In-Reply-To: <c03385c4f862f04406dc4b5f15379c0be921c98a.1636552075.git.lorenzo@kernel.org>
References: <cover.1636552075.git.lorenzo@kernel.org>
        <c03385c4f862f04406dc4b5f15379c0be921c98a.1636552075.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 10 Nov 2021 15:42:33 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

A bit more description here would be good.

Also suggestion from patch 1 carries through to maybe spell
out sensor-hub in the property name?

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index d9b3213318fb..502438f14e19 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -61,6 +61,10 @@ properties:
>      type: boolean
>      description: enable/disable internal i2c controller pullup resistors.
>  
> +  st,disable-shub:
> +    type: boolean
> +    description: enable/disable internal i2c controller.
> +
>    drive-open-drain:
>      type: boolean
>      description:

