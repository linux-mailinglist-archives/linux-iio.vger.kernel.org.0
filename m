Return-Path: <linux-iio+bounces-23003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F8B2CB4E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6181A05028
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE744307AC3;
	Tue, 19 Aug 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suyIBS+H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02E267B89;
	Tue, 19 Aug 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625526; cv=none; b=L4DS1RV/krcYFaX0/18AsQPX03tK/sya8zMFi3YuodBWW9PZRR285q93wda9JJXwotKkgCTd5pT/TgWGvWTo2ADq/EOtp5/8/gY//anBnxflhpJtrfy5o4FTNpkUoKmfjBzppumQ/S/z551yhL1tqm+y1tcBc9PYUcluML2fox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625526; c=relaxed/simple;
	bh=DtrKhkB5ryM3ThMC1G9NOf7X3JSBqYTo0pkcmv1KFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7Qtaa/exu+dJENZnipM1UVf+ljVtWx3RPy5Yg/cVTcu6BJfdP1IqIQw+Vkd/oFffHiE1sR1UWE8bMYsUp/PmlFMMb5zT81/mLQuW54EA6LjP4VKqr6NElxjVn6mwjhM2MpU6ruYbGHyFsUpOId4OTrQcwh7fVi/wl3mHKVPvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suyIBS+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30523C4CEF1;
	Tue, 19 Aug 2025 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625526;
	bh=DtrKhkB5ryM3ThMC1G9NOf7X3JSBqYTo0pkcmv1KFFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suyIBS+Hz9tOiYiyMeqt0DrLTdK10UHR/pK/mcyUh74/6m2e6llELdkzR0qKnI4Cv
	 AFNxspBPi6ItduOnJtf8IF+rd6D2J0FdtsS/UDAiFKF5yNBZMCToKyYuP2hrQ2wS0L
	 AQyo0gcajG0jPk4a37rYP6TSWLL4yMqjy6evj6NyIEPVnIIoCFsgjFFLEGTFneX6pU
	 WH1iH9znN2nUtR1qpNTmENsDEyskR2M2fcLhQhgUu0v2sG/bcaOcFdk2lDyGTIIMA9
	 NMTK+mAcPNG4nn+rKRXu1IWEpNuzt5ugp3xrTAiMWN+uTqoTB98scumWC0flba699/
	 +ZalplsFY/USg==
Date: Tue, 19 Aug 2025 18:45:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: "Erim, Salih" <Salih.Erim@amd.com>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "andy@kernel.org" <andy@kernel.org>, "Simek, Michal"
 <michal.simek@amd.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
Message-ID: <20250819184442.25f6904e@jic23-huawei>
In-Reply-To: <BY5PR12MB4212A540F9799D6F326003388B30A@BY5PR12MB4212.namprd12.prod.outlook.com>
References: <20250819150448.1979170-1-salih.erim@amd.com>
	<BY5PR12MB4212A540F9799D6F326003388B30A@BY5PR12MB4212.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 15:10:15 +0000
"O'Griofa, Conall" <conall.ogriofa@amd.com> wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>

I'm not entirely sure why but b4 only picked up:

[PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
    + Acked-by: Michal Simek <michal.simek@amd.com>
    + Acked-by: 
    + Link: https://patch.msgid.link/20250819150448.1979170-1-salih.erim@amd.com

Anyhow I fixed it up to include Connal's ack whilst applying.

Salih and Connal, thanks for stepping up.

Jonathan

> 
> > -----Original Message-----
> > From: Salih Erim <salih.erim@amd.com>
> > Sent: 19 August 2025 16:05
> > To: Erim, Salih <Salih.Erim@amd.com>; O'Griofa, Conall
> > <conall.ogriofa@amd.com>; jic23@kernel.org
> > Cc: dlechner@baylibre.com; nuno.sa@analog.com; andy@kernel.org; Simek,
> > Michal <michal.simek@amd.com>; linux-iio@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Subject: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
> >
> > Removes Anand Ashok from maintainers and adds Salih and Conall as new
> > maintainers.
> >
> > Signed-off-by: Salih Erim <salih.erim@amd.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml | 3 ++-
> >  MAINTAINERS                                                    | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > index a403392fb263..3ae1a0bab38f 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Xilinx Zynq Ultrascale AMS controller
> >
> >  maintainers:
> > -  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > +  - Salih Erim <salih.erim@amd.com>
> > +  - Conall O'Griofa <conall.ogriofa@amd.com>
> >
> >  description: |
> >    The AMS (Analog Monitoring System) includes an ADC as well as on-chip
> > sensors diff --git a/MAINTAINERS b/MAINTAINERS index
> > daf520a13bdf..b4b27a31a782 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -27537,7 +27537,8 @@ F:    include/uapi/linux/dqblk_xfs.h
> >  F:   include/uapi/linux/fsmap.h
> >
> >  XILINX AMS DRIVER
> > -M:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> > +M:   Salih Erim <salih.erim@amd.com>
> > +M:   Conall O'Griofa <conall.ogriofa@amd.com>
> >  L:   linux-iio@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> > --
> > 2.34.1  
> 


