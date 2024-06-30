Return-Path: <linux-iio+bounces-7080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C3A91D133
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAD3B20BAA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D21386B4;
	Sun, 30 Jun 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fujn42pJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393A612F5A1;
	Sun, 30 Jun 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719744107; cv=none; b=fFwDK1dJckAMe6Ayxn1NwMR+CiLSv/F3NADPK5VSdycLzOvKX+N2vecFaTuT91xVxY6nr1X2GaJsPbJaDQsRwOHp4z5vPKZH+MkjRNtVMwERZgICcsu27T9TmZu+FkfPU0hAt7VPIjPHy586oZbR8dxiE8UXnm8cEsMaoXK40bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719744107; c=relaxed/simple;
	bh=g8gLJ95I+E9cX6fK2eb0k1vprsOO40XO2PzIS0mdNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qASnbsB/AjU7WUBWHBo+G0iedHy89tAu/QHa+9JteTWdhd2SGTHMXXLOJ5TPMQnwBf6odH3Yp5gCWFxYPOlfq0jofA6SQDv1IBTvO/pNOjtQzfaHwdQprfUJ/0OWOao/A9+AV21lcIQifSpx7GEn3pvGT/hn6FJggxVkkd748PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fujn42pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F05CC2BD10;
	Sun, 30 Jun 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719744106;
	bh=g8gLJ95I+E9cX6fK2eb0k1vprsOO40XO2PzIS0mdNbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fujn42pJsncMk7wapKOCQDcGvDfGNRLSp2Ftbwr1klxJk+BDYn1OUAzwTAcWwZ+1z
	 pf6fhyG/F6JjJTQl+5+7rYjev8MBh7lV1HgSW60ND5genAudxDpFWg8idTVONdiYjN
	 veE5AU5q4uGDohbiJh9uXtrLFqeX0h5g0KL94sNaRIJZj5ekDffHooKPUZhg2k9iMr
	 rzLuH5SSZ1RAGdMxSxQsRynHT45nAa8B2JvfCPSaAg/D5Zgz2kv+4fP7pCEIAZOdSr
	 PUEnmyu2K6icfkI40Gwgp6jYsQFHPpyy1rt283F+lLtLV61Qc0Rvb/7v9dr6T1tM9K
	 k10EDHuQiOeKQ==
Date: Sun, 30 Jun 2024 11:41:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal
 Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: xilinx-ams: Add labels
Message-ID: <20240630114139.13d7bd1b@jic23-huawei>
In-Reply-To: <20240623125901.03f0fe6f@jic23-huawei>
References: <20240620204842.817237-1-sean.anderson@linux.dev>
	<20240623125901.03f0fe6f@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 12:59:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Jun 2024 16:48:42 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
> > Label all the channels using names from the reference manual. Some of
> > the "control" channels are duplicates of other channels. The reference
> > manual describes it like:
> >   
> > > The AMS register set includes several measurement registers that are
> > > written to by the PS SYSMON unit using the single-channel mode
> > > (sequencer off). These voltage measurements are performed using the
> > > unipolar sampling circuit with a 0 to 3V range and do not have alarms
> > > or minimum/maximum registers.    
> > 
> > So I think these really are measuring the same voltages but in a
> > different location. In which case, sharing labels makes sense to me.
> > 
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>  
> Hi Sean,
> 
> This LGTM, but I'd like some feedback from others more familiar with the
> driver and device before I apply it.  If everyone is too busy and
> I don't get any replies for a few weeks I may pick it up anyway.
> 
> Feel free to poke me if I seem to have forgotten in say 2 weeks.
Long enough. Applied.
> 
> 
> Jonathan
> 
> > ---
> > 
> >  drivers/iio/adc/xilinx-ams.c | 107 +++++++++++++++++++----------------
> >  1 file changed, 59 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index aa05f24931f9..f051358d6b50 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -222,7 +222,7 @@ enum ams_ps_pl_seq {
> >  #define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
> >  #define AMS_CTRL_SEQ_BASE	(AMS_PS_SEQ_MAX * 3)
> >  
> > -#define AMS_CHAN_TEMP(_scan_index, _addr) { \
> > +#define AMS_CHAN_TEMP(_scan_index, _addr, _name) { \
> >  	.type = IIO_TEMP, \
> >  	.indexed = 1, \
> >  	.address = (_addr), \
> > @@ -232,9 +232,10 @@ enum ams_ps_pl_seq {
> >  	.event_spec = ams_temp_events, \
> >  	.scan_index = _scan_index, \
> >  	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
> > +	.datasheet_name = _name, \
> >  }
> >  
> > -#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _alarm) { \
> > +#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _alarm, _name) { \
> >  	.type = IIO_VOLTAGE, \
> >  	.indexed = 1, \
> >  	.address = (_addr), \
> > @@ -243,21 +244,24 @@ enum ams_ps_pl_seq {
> >  	.event_spec = (_alarm) ? ams_voltage_events : NULL, \
> >  	.scan_index = _scan_index, \
> >  	.num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
> > +	.datasheet_name = _name, \
> >  }
> >  
> > -#define AMS_PS_CHAN_TEMP(_scan_index, _addr) \
> > -	AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr)
> > -#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr) \
> > -	AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, true)
> > +#define AMS_PS_CHAN_TEMP(_scan_index, _addr, _name) \
> > +	AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr, _name)
> > +#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr, _name) \
> > +	AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, true, _name)
> >  
> > -#define AMS_PL_CHAN_TEMP(_scan_index, _addr) \
> > -	AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr)
> > -#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _alarm) \
> > -	AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _alarm)
> > +#define AMS_PL_CHAN_TEMP(_scan_index, _addr, _name) \
> > +	AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr, _name)
> > +#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _alarm, _name) \
> > +	AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _alarm, _name)
> >  #define AMS_PL_AUX_CHAN_VOLTAGE(_auxno) \
> > -	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(_auxno)), AMS_REG_VAUX(_auxno), false)
> > -#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr) \
> > -	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(AMS_SEQ(_scan_index))), _addr, false)
> > +	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(_auxno)), AMS_REG_VAUX(_auxno), false, \
> > +			 "VAUX" #_auxno)
> > +#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr, _name) \
> > +	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_SEQ(AMS_SEQ(_scan_index))), _addr, false, \
> > +			 _name)
> >  
> >  /**
> >   * struct ams - This structure contains necessary state for xilinx-ams to operate
> > @@ -505,6 +509,12 @@ static int ams_init_device(struct ams *ams)
> >  	return 0;
> >  }
> >  
> > +static int ams_read_label(struct iio_dev *indio_dev,
> > +			  struct iio_chan_spec const *chan, char *label)
> > +{
> > +	return sysfs_emit(label, "%s\n", chan->datasheet_name);
> > +}
> > +
> >  static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
> >  {
> >  	u8 channel_num;
> > @@ -1116,37 +1126,37 @@ static const struct iio_event_spec ams_voltage_events[] = {
> >  };
> >  
> >  static const struct iio_chan_spec ams_ps_channels[] = {
> > -	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
> > -	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10),
> > -	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS),
> > +	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "Temp_LPD"),
> > +	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE, "Temp_FPD"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, "VCC_PSINTLP"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, "VCC_PSINTFP"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, "VCC_PSAUX"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, "VCC_PSDDR"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, "VCC_PSIO3"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, "VCC_PSIO0"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, "VCC_PSIO1"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, "VCC_PSIO2"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, "PS_MGTRAVCC"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, "PS_MGTRAVTT"),
> > +	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, "VCC_PSADC"),
> >  };
> >  
> >  static const struct iio_chan_spec ams_pl_channels[] = {
> > -	AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, false),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, false),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, false),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, true),
> > -	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, true),
> > +	AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "Temp_PL"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, true, "VCCINT"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, true, "VCCAUX"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, false, "VREFP"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, false, "VREFN"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, true, "VCCBRAM"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, true, "VCC_PSINTLP"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, true, "VCC_PSINTFP"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, true, "VCC_PSAUX"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, true, "VCCAMS"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, false, "VP_VN"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, true, "VUser0"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, true, "VUser1"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, true, "VUser2"),
> > +	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, true, "VUser3"),
> >  	AMS_PL_AUX_CHAN_VOLTAGE(0),
> >  	AMS_PL_AUX_CHAN_VOLTAGE(1),
> >  	AMS_PL_AUX_CHAN_VOLTAGE(2),
> > @@ -1166,13 +1176,13 @@ static const struct iio_chan_spec ams_pl_channels[] = {
> >  };
> >  
> >  static const struct iio_chan_spec ams_ctrl_channels[] = {
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL),
> > -	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, "VCC_PSPLL"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, "VCC_PSBATT"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT, "VCCINT"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM, "VCCBRAM"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX, "VCCAUX"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL, "VCC_PSDDR_PLL"),
> > +	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR, "VCC_PSINTFP_DDR"),
> >  };
> >  
> >  static int ams_get_ext_chan(struct fwnode_handle *chan_node,
> > @@ -1336,6 +1346,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
> >  }
> >  
> >  static const struct iio_info iio_ams_info = {
> > +	.read_label = ams_read_label,
> >  	.read_raw = &ams_read_raw,
> >  	.read_event_config = &ams_read_event_config,
> >  	.write_event_config = &ams_write_event_config,  
> 
> 


