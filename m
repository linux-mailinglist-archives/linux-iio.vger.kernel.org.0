Return-Path: <linux-iio+bounces-3937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB5892BF2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8FA1F21B53
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0055B3A29F;
	Sat, 30 Mar 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrQKTc6l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00148467;
	Sat, 30 Mar 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815025; cv=none; b=FbfuHKTbxqkhzuCaCaWGy0zFs+AHmJR/6qI5F8DTYpO5o7e0nenFoC8wlRmyrkueM+sbcKWUozjbC44H4UyoSkshzPvid4icmZiw0fdA23893SO9D2gw7ZGN5Qvgsix1+3YNZ9fgexs6bX8QzhqGEzXwKUJgt5E5cuDT2jtEKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815025; c=relaxed/simple;
	bh=O+eTHfFAtVjor9CRWvA8FEGOBzS6Eo9xmAXvjQu2Sk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu3LdHgQeVRKi2C+8ZzojQWp8AcDDCDkVtcvAy/MmO8WFmi6Ggr4t4fYsjk68aOdQNp13+QAPuuNH16W8M6W+j7fswmOF4Am+U35jDIodMEYYOcLH8cejZD4Wy4gbK2JIEJpLdztIIz61g53DtilYofiwLxJ2tAZgLx09U5H5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrQKTc6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C57C433C7;
	Sat, 30 Mar 2024 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711815025;
	bh=O+eTHfFAtVjor9CRWvA8FEGOBzS6Eo9xmAXvjQu2Sk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GrQKTc6l46g8xBeKD4lZX+2C5FYlBeEPvZfo/NEQeAcqEiRgsuNShCw4ljXRJ785I
	 nEA7CFQ9QB3PiNnY2uoKXwYtNfnFmoH7V8m/zRPdPGGCzP/3Dn/B9hj0PCW0quM78s
	 h9YIuHYIFS4Lry5sbvbfjWB0SRUdl//JgqM1HKsVNgTX58R4WXUBSfRTPEAE0GEi1Q
	 Xj5PNk0YdB+qHgGmFGV5dXsInHZx8wJpV2Ag4Va5g+HQaqwc9MS+C+YEj8jtV1nZSz
	 CxdNs8HPGVmDbEnWCOvfm9Si7wExWs5YPAN8kdl9WiGhfOg3ZtxwvQ8bJYsPRVwVUP
	 YZAj26hHQBdvA==
Date: Sat, 30 Mar 2024 16:10:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: inv.git-commit@tdk.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Message-ID: <20240330161012.0b49846a@jic23-huawei>
In-Reply-To: <20240329-fifth-earpiece-78daf4d943ce@spud>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
	<20240329151535.712827-3-inv.git-commit@tdk.com>
	<20240329-fifth-earpiece-78daf4d943ce@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 15:49:26 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Mar 29, 2024 at 03:15:35PM +0000, inv.git-commit@tdk.com wrote:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > Add bindings for ICM-42688-P chip.
> > 
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>  
> 
> My initial thought was that you're missing a sign-off, but is
> "inv.git-commit@tdk.com" some system you have to bypass corporate email
> garbage?

Common enough setup, as long as the From: line matches the sign-off, git will
ignore the email address used to send it when the patch is applied.

> 
> > ---
> >  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml         | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > index 7cd05bcbee31..152aec8d82ff 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > @@ -31,6 +31,7 @@ properties:
> >        - invensense,icm42602
> >        - invensense,icm42605
> >        - invensense,icm42622
> > +      - invensense,icm42688  
> 
> Can you add this in alphanumerical order please?
> 
> Also, this patch should be the first in the series.

Agreed on both, otherwise this series LGTM

Jonathan

> 
> Thanks,
> Conor.
> 
> >        - invensense,icm42631
> > 
> >    reg:
> > --
> > 2.34.1
> >   


