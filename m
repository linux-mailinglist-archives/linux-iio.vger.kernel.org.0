Return-Path: <linux-iio+bounces-13437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4269B9F194A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 23:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64274163557
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6ED1A7060;
	Fri, 13 Dec 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMF1VBhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443562114;
	Fri, 13 Dec 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129769; cv=none; b=B1xQyqisE4D49hQe2mAzu/pKvFnEQieyTEERqILNI89CzzZa1kg4XjVYLhM+kvdw+huibnH3wdJtAkcwE4xg/iTKwrIJT2E/9JtAykoEeA8Y7IKYYgXy/WT+kQyTDblZ4V2b/15mnCcbBJW89kb0unLnEjMCJ/GvpWbv2HGuk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129769; c=relaxed/simple;
	bh=BjX0VDPGHA5y83hhzu2EPb7yjqStV6ntNJC4ipvu+JM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iBles1atRhIfKemOCmhWle4ynss5Qrz2th0x5ZJoOM5kzLH3NXMz2Rjrt32mon9BN8uO9q6q7xhtvfFsvq9cOhaAPIUVQYcN5PhNozK0B8yrhhZqmnNm+CX8fgpuJrWZdJG3oFMKQHF6QU5t0PMi7GrQWQeUYDWMl5k6/+PWs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMF1VBhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BBAC4CED0;
	Fri, 13 Dec 2024 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129769;
	bh=BjX0VDPGHA5y83hhzu2EPb7yjqStV6ntNJC4ipvu+JM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tMF1VBhiap2XocNJchcool8rG+hEsgRF4GWq8OKn1lwtRQsBpNQLGtdOsYgZaki2L
	 1xV/UNu9KfFjkZLcPqJJ00Xdby0RgA6fXraNZyV/pUaSLysJENGiqK4QWpBpc0zu7t
	 /ukI0LFI9QZ3LkdjVHYgclifQ/sznxWj0aOKZ/3mYQpqjDI50taYbL2bOphuccGGTZ
	 /snKJWMCN+6yzaU6tfsNM7604frhp8L8TwLh1v1ucJn8QnE7AKrU+PeG70KNkTu85D
	 0+WBrCgI9rnROIGhd2urMOEaBuNuDBkH7vu/5efjhPElT1k8HrJe4gTBw4bUO93EjO
	 ts0qdhn9akRMw==
Date: Fri, 13 Dec 2024 16:42:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
 conor+dt@kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, 
 eraretuya@gmail.com, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 lars@metafoo.de
To: Lothar Rubusch <l.rubusch@gmail.com>
In-Reply-To: <20241213211909.40896-4-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-4-l.rubusch@gmail.com>
Message-Id: <173412976723.2600598.3789006007464686028.robh@kernel.org>
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names


On Fri, 13 Dec 2024 21:19:05 +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor.
> 
> When one of the two interrupt lines is connected, the interrupt as its
> interrupt-name, need to be declared in the devicetree. The driver then
> configures the sensor to indicate its events on either INT1 or INT2.
> 
> If no interrupt is configured, then no interrupt-name should be
> configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> mode. This allows sensor measurements, but none of the sensor events.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml:45:17: [error] string value is redundantly quoted with any quotes (quoted-strings)
./Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml:46:22: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241213211909.40896-4-l.rubusch@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


