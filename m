Return-Path: <linux-iio+bounces-26011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB67FC3F272
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA8234E696D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6902FB098;
	Fri,  7 Nov 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc+q2iTY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E32E229C
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507630; cv=none; b=UhiXRQrU+sie8Urn5EDJ/bbDMpYs2dH1DecAdfSjkVxnDdYezn1ASijrLhWUXTRL5cf2gZYFsL8jOu5mHh4oRA5r9z+twnB0WZtk2vwhDGWCuG1VgrPBFMvXvQ5YooF2rWbfQWBpDKTBAbcP2Sme6TMPdb0BS+g5EYeN48eEi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507630; c=relaxed/simple;
	bh=kDAyi9ioMc/rzuwTBPGk8+ebQ5bgGc7bdn52u50c0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqt5xtWTwDodaMCaVC219SP7Kb/M+HS7BdXiP5WhIQx1PQ6YwCvTJSSYFfM+vafZVQPly2npi9PoDjimaij9Ej5KDOe6XUVeeFnGCpFtXGjn47XrzGmdMdWHmtTVapeCn3N7xydMwGo+wRbj57sVga8H3z27+mT20J7cjAVPhhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc+q2iTY; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso344122f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762507626; x=1763112426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geTnwrqDK13fknylndNDrxsZhVlDgoBw/RlgWBbQVGk=;
        b=cc+q2iTY7BCdrO/UDtugvs/5XQt2hTUlEOOcVDDJy2MTcywH+bCzO1YwJnkUk+g4/D
         AT5gKDAv7DC9va9b2V0je/2EdiTp0OLan4C2y4pifBtUa+fnzVbsTAPypBRES2P2wwzv
         R0cbHJDrKY9NT2o+AY89Z6vZbjOCDioau/ToNkkcL/atTCtIRICu9zICXWmyQ58ZUguy
         wWpXR6g2h/PdgI3W6TAfFMhKjNag/YZYdD2hqq4CKcRBlgoF94J6jRVYPxFMt1ALd8/1
         nPBF+JQ8XLuaiPulpA3G5mbtKFkX0ZTz+1wMjIzSWj0IohTzy7z6LZoMWcNDvisF/ll6
         2KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507626; x=1763112426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geTnwrqDK13fknylndNDrxsZhVlDgoBw/RlgWBbQVGk=;
        b=QmG4PgICZ82u/Hgx1iOVVdja4DE6A6bOBjDA9ogaUAT5csEA47UmYLG2jjMcC6mVss
         BYg/ccW+Hcxx9AERVwhKhyglqGf0EbsZjVJZ4skqjveamkPC1c2SIV058RBTHNAzKAbs
         ilUsN8u3lwgtdvOoi66ptLnhn3WloU6w10b9pNEjlNZWiy2m8nUD/KREC1/5GcBTtfck
         XFFhvPaY19CRNLvgQBIJM5VdVkF6jPuK3OBwmS7eQ6eMGWstJeexOffg0E9wMlXHlELT
         uzLjyYkhr9RshElpshO8Vj/3bO0ZomunWRFtqniQsaziw+PrqPHME7JXxMufWUmnID/l
         6/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWoIlSuqF6vtkx86mABS0CMCxl5ptxeuA5anjXV+nALBKx+pTKRxrQfh1SGO9f/dFVmwkQbp6+lpmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPnGWAbCNdh8K+w7QpDo2weqJqJ4W9JZtUsiTrxXRlqclPkrx
	n8fUDWYFe6Bq/5O0OPR/5HrDcCbA0Mzk1mqQjdjQoBrL+U+GUDU+/1KT
X-Gm-Gg: ASbGncuRAljQuOPkDdgPTfUN6de4YefZ4TQ3s1DASUr0XnZPxsmvPZ62t8uTecTIzSs
	Og8447ooJ+MwqlbYDoCyc6EnpQiIgEXRB4LpjJGqZzcbOleit9cOQJ7mPgbEXwIzdHWPMVUtgQu
	alH1r8OUcOjQxANmhDPdBTD+ZB/XutC4QJWys5lCYI6M+wPD6SK8k9Q1t4sXYt+yKqviEi6005g
	456DWAqKO+PyEpPsSVFB6DRkrfOy3/y3LJVumdYmW1HqHhNqv4hcxUPJbMJ2e/EZIQAcdvDgZxI
	Qh9Qu3jyStqi6kqQqML2BMwrXO/PPZGyFOt2A35ZXCp0eyrL8ymc00xJRMUuLY2luTs7kdJBC95
	BKBD8uF3ej4HTPWMMDf+luFPnkKw2WUbYKucgYoABziVrRsdJegnNv/5vftzO7wEc7i9ivPmu5g
	1Ap7c3q8b9x3PeDmb4hMcMREe74qbR+4pdZoGO1M1qHRc=
X-Google-Smtp-Source: AGHT+IGyQU5w/jXirb835rluq2NuRTlYaAkODeiLEa1G2akDocz91dbrmmPOmGY260WwpC+esGaMPA==
X-Received: by 2002:a5d:5850:0:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-42b26fcfe3cmr1102328f8f.31.1762507625992;
        Fri, 07 Nov 2025 01:27:05 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.212.142.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm4047020f8f.36.2025.11.07.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:27:05 -0800 (PST)
Date: Fri, 7 Nov 2025 10:26:46 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Message-ID: <20251107092646.qaeocpvux4kjfu3i@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-4-apokusinski01@gmail.com>
 <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>

On Thu, Nov 06, 2025 at 11:32:07PM -0300, Marcelo Schmitt wrote:
> On 11/05, Antoni Pokusinski wrote:
> > Add sysfs pressure event attributes exposed by the mpl3115 driver. These
> > allow controlling the threshold value and the enable state.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 352ab7b8476c..5f87dcee78f7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
> > +What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
> >  KernelVersion:	2.6.37
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > @@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
> > +What:		/sys/.../events/in_pressure_thresh_rising_value
> This is how it's currently appearing in sysfs, right?
Yes, that's right.

> If so, IIO event sysfs entry generation might need a tweak.
> 
> For what matters to mpl3115 event support patch set, I think this is okay.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> >  KernelVersion:	2.6.37
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > -- 
> > 2.25.1
> > 
Kind regards,
Antoni Pokusinski

