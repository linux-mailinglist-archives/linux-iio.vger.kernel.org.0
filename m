Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32A68035
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGNQ2X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfGNQ2X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:28:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960A02089C;
        Sun, 14 Jul 2019 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121702;
        bh=Axt8sU7UfJ4j3rkf4SzhJPvWZjsC3ZZwTgXi7cfhbiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L1M+ZKOxSLjWg/2oa4p5ee3CdGoZxLgnIYKTAIzm18cGG9q4mrd2gsunnVJmul/NX
         t9NcUqXtaopc5iN+Jai3VwmiQd+AzE1pMT+HBh7cN4enpPK4pbWkmDGnoC6PWWg3KJ
         oTBPLhO1geQHzjwCw+kBGSed4seZ27muIlwLTksM=
Date:   Sun, 14 Jul 2019 17:28:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c
 device bindings
Message-ID: <20190714172815.4f24eac8@archlinux>
In-Reply-To: <89edf867d6abb738527889040f030036173fd5b8.1561802767.git.lorenzo@kernel.org>
References: <cover.1561802767.git.lorenzo@kernel.org>
        <89edf867d6abb738527889040f030036173fd5b8.1561802767.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Jun 2019 12:13:54 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index efec9ece034a..92b48f242356 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -11,6 +11,7 @@ Required properties:
>    "st,asm330lhh"
>    "st,lsm6dsox"
>    "st,lsm6dsr"
> +  "st,lsm6ds3tr-c"
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:

