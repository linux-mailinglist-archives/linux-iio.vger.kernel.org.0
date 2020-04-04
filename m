Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC319E627
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDPlU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDDPlU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:41:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E3F20644;
        Sat,  4 Apr 2020 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586014879;
        bh=xQ97FhWym7EDNwNowNrGj3fKZzyx50jj+V4vKnarv9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t5KLwjXlUYVkIFFs3LRMPj/M0Pweqqab4YgvYaqx1Hesrl9qpJwX5rMjwpI1SAXV7
         fE8g9epwbbZlDeLiCRrPxC/kYbVUh3sFcFCa/ouZ6ksL5rFjpczVsCaPLaBVab2GjX
         u+ohfrTOGqIxboJkuTI+Wf4mt1vHVh7mTQp2j+Fc=
Date:   Sat, 4 Apr 2020 16:41:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 1/2] dt-bindings: st_sensors: add st,lis2hh12 compatible
 entry
Message-ID: <20200404164115.7644bd28@archlinux>
In-Reply-To: <20200330141923.280226-1-rvlander@gaetanandre.eu>
References: <20200330141923.280226-1-rvlander@gaetanandre.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Mar 2020 16:19:22 +0200
Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:

> Add LIS2HH12 compatible entry.
>=20
> Signed-off-by: Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to ignore this patch (and build the next one!)

At somepoint we should look to convert this binding over to yaml.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Docum=
entation/devicetree/bindings/iio/st-sensors.txt
> index 0ef64a444479..3213599c5071 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -50,6 +50,7 @@ Accelerometers:
>  - st,lis3dhh
>  - st,lis3de
>  - st,lis2de12
> +- st,lis2hh12
> =20
>  Gyroscopes:
>  - st,l3g4200d-gyro
>=20
> base-commit: b723e9431b77976b83efb90178dfcada3405321c

