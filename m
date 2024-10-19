Return-Path: <linux-iio+bounces-10778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959D9A4DAE
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79F01C239DF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310A81E049D;
	Sat, 19 Oct 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDi1kQnD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5D1E0497;
	Sat, 19 Oct 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339743; cv=none; b=DnjPVtN7ZjQjMtH9n04ha9CJGUrTg2074dlMAfRgG/+0DRm5gGljIcfkkls4KFvMEv7ue4XytYWknu7N8sKrx+9f3QKq04nQa+/nMF49Qa4S9v6dXcioK2Crmo1pDJfD5EI7j9Xr/axkt22i2i5RMm94zW9A0S2abTEUWWcXvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339743; c=relaxed/simple;
	bh=aWpXp64R1ZdsAExMlekEcQjsrf5zry9qe2T+DzRd+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8HcIZVWsZjPdPGtMPHKwoiXARuBifS+4Q2etHHV3EyuoRopTH8NDTmlDFRWqzdHyWaJiK/BF7jb43RTMRcuUrz5s/4bV2yYVdrajimMN5gU0o3Ey61OMFjKXY5YCO2nv/kokxibMGa9nqzgy0/4JnqiXrv5nUGYRiUmZ3KuMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDi1kQnD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2146427a12.0;
        Sat, 19 Oct 2024 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729339741; x=1729944541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URaCTtzRBRQ3eOPnATzkwpXp8SklgqBrCw6MZgMahAM=;
        b=DDi1kQnDICSCQF2+HCXWD30fA/DDX2gtdMIShiwonIk03P6dsH3yfJRXQROPR+zv5R
         8GV8Tg44vV9gun5NJyLCn5OTyux2MVoBP9K96HC3s+QfKY6X6Byhc8zv3VNMrPEJxpre
         B2dqD5MLJwEplpv4PJSTu2aWLYixt96yCMkDefHKOHStMSrjeSBbrnDdY0U3/40DSZvd
         U/Aq6smnlncRxa/kMWSs09G3Rgd7EJzattpoLLkUsMFJ0Rux3IF3uOmbK5F/xndj5KMD
         hp/t5aoRAWBoSA2rIZpv5EoVxqPDweeHb4E2ELbLl3SBr4UN+dmDILUu+JWwwZSpT5My
         M4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729339741; x=1729944541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URaCTtzRBRQ3eOPnATzkwpXp8SklgqBrCw6MZgMahAM=;
        b=c+jpbe70TvSUa9TVQ+Axrvfeg3dc1buDvuaaDykVJzDYAIniW7RE5aQLICx3GVQ4hx
         pR8LtoxV80OUEKTLy/3xymNuzp3L8S79MUonCVJfJV6hRnTSHM/b/3aovoXLdVkO3qSK
         J3+umOHu4LaZkW/nw9JYxWszRsurMfd5GTlOHDs8eovd9wxtKZGUjeCQDDlADi4t/wCo
         TyVBl0mvjWc2Ox/KT3iUw9GIlHla780jFK96cawYF/myz/57lQVcovgaTKncOdtBMiNj
         mrdBzkJnUVlDOK0fvQYJg0htezJccBzMJYIN2t92c1AjHTI3Y2bxB+UdMDi1x04fhE+/
         yezw==
X-Forwarded-Encrypted: i=1; AJvYcCUbtf97K36Z6Bg6gCo7zEFARnEvLiGjVFnwlOg+5p2wF5oHys88PbBVksr7JGe5wbxbrj2o5boNCGkd0RG9@vger.kernel.org, AJvYcCUeZRos8ktUsO/PBpSW2+jtrO07NT6o7LJ+Uii4xNdAv18cLO/NBnYZwqn95yR4dTXVYWxbWBceyDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWWrssg2UB6U7muaKPJS0iUzjNwF5Y7UukL6AP3J+x3r92dGR
	l5zbugz4xu7aEuwzppkupPuCBVMfkPQgfkMqNA2bvgK4SHq2Qe9cusvwX8AOwGykMQ==
X-Google-Smtp-Source: AGHT+IElUe6HfZmYRY33iKeaoCdrLY4wdfbJkOhr4S2CC8sZmfrHprqSmh6M750j2euiywPO2Muklg==
X-Received: by 2002:a17:90a:c398:b0:2e2:9077:a3b4 with SMTP id 98e67ed59e1d1-2e5616c3c91mr6805881a91.7.1729339741206;
        Sat, 19 Oct 2024 05:09:01 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:190:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5612dcacdsm3877901a91.50.2024.10.19.05.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 05:09:00 -0700 (PDT)
Date: Sat, 19 Oct 2024 12:08:55 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Karan Sanghavi <karansanghavi98@gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Add Null pointer check
Message-ID: <upme6hy6sroszgdhj7ucg6iksxuim26grhgaypegu2vzdtsp6z@ne33c5yhbhe2>
References: <20241018-cid1593398badshift-v1-1-11550a10ff25@gmail.com>
 <20241019122133.13d59dfb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019122133.13d59dfb@jic23-huawei>

On Sat, Oct 19, 2024 at 12:21:33PM +0100, Jonathan Cameron wrote:
> On Fri, 18 Oct 2024 18:54:42 +0000
> Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> 
> > Add a Null pointer check before assigning and incrementing
> > the null pointer
> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> 
> It would be a bug if rsp_size was anything other than 0 and rsp is NULL.
> So this looks like a false positive as the loop will never be
> entered.
> 
> How did you find it, in particular have you managed to trigger this
> in the driver?
> 
> Jonathan
> 
>

I found this bug in Coverity scan with Cid: 1504707.
Link below, for the same.
https://scan7.scan.coverity.com/#/project-view/51946/11354?selectedIssue=1504707

Rsp here is a void pointer received from the function arguments 
which can be NULL for a no respone call.
Thus incrementing the NULL pointer can lead to some unexpected 
behavior which cross my mind thus added the check. 


> > ---
> >  drivers/iio/chemical/sps30_i2c.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
> > index 1b21b6bcd0e7..d2142e4c748c 100644
> > --- a/drivers/iio/chemical/sps30_i2c.c
> > +++ b/drivers/iio/chemical/sps30_i2c.c
> > @@ -105,16 +105,18 @@ static int sps30_i2c_command(struct sps30_state *state, u16 cmd, void *arg, size
> >  		return ret;
> >  
> >  	/* validate received data and strip off crc bytes */
> > -	tmp = rsp;
> > -	for (i = 0; i < rsp_size; i += 3) {
> > -		crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> > -		if (crc != buf[i + 2]) {
> > -			dev_err(state->dev, "data integrity check failed\n");
> > -			return -EIO;
> > +	if (rsp) {
> > +		tmp = rsp;
> > +		for (i = 0; i < rsp_size; i += 3) {
> > +			crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> > +			if (crc != buf[i + 2]) {
> > +				dev_err(state->dev, "data integrity check failed\n");
> > +				return -EIO;
> > +			}
> > +
> > +			*tmp++ = buf[i];
> > +			*tmp++ = buf[i + 1];
> >  		}
> > -
> > -		*tmp++ = buf[i];
> > -		*tmp++ = buf[i + 1];
> >  	}
> >  
> >  	return 0;
> > 
> > ---
> > base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> > change-id: 20241018-cid1593398badshift-9c512a3b92d9
> > 
> > Best regards,
>
Thank you,
Karan.

