Return-Path: <linux-iio+bounces-2074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4330A844635
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 18:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00389283B25
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53CB12DD8C;
	Wed, 31 Jan 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVT80oq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2012CDBE;
	Wed, 31 Jan 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722343; cv=none; b=X09A36qf4CKgJ3hmBuopxpdROux5HanseA+RPpCWGyKDfmPoPVwfORoSnfTx3KKR+pyeItet1qO4iVHbWHS95mTAVI1MckbCodCnvfqIdR9TlVm+G9VQ4+Z3Ja7oxufyTP93F2QCN0BVZbBYsI3DWlAf8et6U47is7xNApJgyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722343; c=relaxed/simple;
	bh=ymf3IkwEYzaNvmvcgkzqSo+sRt3EeMMUaMZxfyXNPdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD/rD5UvfMpwfwfZnwaSTntZSIx2Ks0OSUsjuMV0zRGAlZlYshJwQiOjs/A5MxG5C12Bb6D0hh5fTfNxOME97F71vkmDjn6CVMlljDlAHpEJQWzMjR9cFm7Pc+x9JDsuBo4yGGnfAm1jz3PArBCq9w/sjcqvYFKIJUXchR2KHC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVT80oq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A44AC433F1;
	Wed, 31 Jan 2024 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706722342;
	bh=ymf3IkwEYzaNvmvcgkzqSo+sRt3EeMMUaMZxfyXNPdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVT80oq3uTeYJVU/zGRS4qiVsS86cnIbVYJ1pz8VLCfuZy1Om9TnGzgo0sNQYU52u
	 S5eG3SrBOK8lWwbK6kBVpIS+bZ4thdD22XamItOH2tzFcKYWfytUrRUIhjwC1yjMsM
	 cnTBI4jb9+J/ur1CLq4JZqXj2h1jVP2eQgOFj0KkDPiJ0m5MnL3JH9a2mQi0+ynZMi
	 iO5smISNLAApNXcLdwiY7xOKq+dgHKzLziLoHL0nxiwCBsf2oGnic+wvgo+L6I4imN
	 RalRMnoJH4NttIZM8r4tn72+mpE0hSMmx73HaONbbKs7nC38sB+6g51+MQnOFFBqLe
	 uHmtamfzblX+w==
Date: Wed, 31 Jan 2024 11:32:20 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, jic23@kernel.org,
	linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <20240131173220.GA1647997-robh@kernel.org>
References: <cover.1706441008.git.lorenzo@kernel.org>
 <189b903e939e15d98d198db60e2ca0619b116870.1706441008.git.lorenzo@kernel.org>
 <51f4782f-09d8-448f-a693-e0c711bee18d@linaro.org>
 <ZbeoczLjkGG8pogL@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbeoczLjkGG8pogL@lore-desk>

On Mon, Jan 29, 2024 at 02:30:27PM +0100, Lorenzo Bianconi wrote:
> > On 28/01/2024 12:25, Lorenzo Bianconi wrote:
> > > Add device bindings for asm330lhhxg1 IMU sensor.
> > > Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> > > all the features currently supported by asm330lhhxg1.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > index 28b667a9cb76..7ba3de66a2e1 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > @@ -49,6 +49,9 @@ properties:
> > >        - items:
> > >            - const: st,asm330lhb
> > >            - const: st,asm330lhh
> > > +      - items:
> > > +          - const: st,asm330lhhxg1
> > > +          - const: st,asm330lhhx
> > 
> > lhhx is compatible with st,lsm6dsr, so some explanation would be useful
> > why it is not included here.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Do you mean something like:
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 7ba3de66a2e1..92feba6e2427 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -35,6 +35,7 @@ properties:
>            - st,lsm6dsv
>            - st,lsm6dso16is
>        - items:
> +          - const: st,asm330lhhxg1
>            - const: st,asm330lhhx
>            - const: st,lsm6dsr

No, that's not right because you just changed the existing user.

You need to explain why "st,lsm6dsr" is not needed as a fallback or you 
need your original change with "st,lsm6dsr" added on the end. (And group 
it next to the original entry, not at the end.)

The question to ask is whether software that only understands what 
"st,lsm6dsr" is will work with this newer device.

Rob

