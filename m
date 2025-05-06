Return-Path: <linux-iio+bounces-19206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E0AACD5A
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C639830AA
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1EB28642D;
	Tue,  6 May 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pN55Xva5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54628137F
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746556517; cv=none; b=fH5OkAefoCJSRoIprcjkKQbiMuX8TJ0eT0BogGWLrU7rBCZuhBSrcWmLgcHGpFZ6O+p/64PCNoJYmaFnIrMcYO9zYI0o5OZay3ocS2lTR2F75eAB8l9xo0mGfP27C2Y9sxnh4bRLgtvyDqjYjKxPIhc0u7RDd+DqP/9/ZkaQ67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746556517; c=relaxed/simple;
	bh=oFmAmC6t4WsPlHZBgOJsdR6EG8o/Tm2yBx4/IVl9QH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wl1AQMOlW4WWbee+URMoFS8c5a7D8PAnmKXAcvhN8euDkHYV6/NVdKpUuHrIYQ4R5CabQVqC3mdKmJgk7xoYBqq482+cc6O4/oOsQaYxVhutN9a2OKNXCo+InfuQc66HcjIIW7bzh25EAE52/D06TqPQUAH3cv/20YXS7RtqYDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pN55Xva5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso4397552f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746556514; x=1747161314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UunZOaxiv1FMCIph+Y0cMA/y3FCJuA3U5gYOuCj4Rc=;
        b=pN55Xva5cBgb286K2lL26fheDE7elnlCtvWvMdOGlNtTbCURstoIVPV7eZR6HqBhpc
         tj7ZkT8RgiWpIAwSh2V3mljDGkT+gHCJMsCUXUfVEe+XKjJNP2Tk6RP3SPmQox88PIFe
         Gu5OvUXyrzRX2AORNoCBNxFWgHaWfua5BVLrqQRqwzeMdjanIgLA27mR4M0jcaXNR/0h
         DrdogEAoEVFP/eIQJEXa5q4aPKFgQ5NTbNUcoUElWvJOePr3Zz1Jk8INqJIf4Fs26g7D
         aPNIrgi9ONNU7xp6Nt/ujAhK+/jX1rtnPr6AQ4JVyduHDRoi0GRSyYYQzhgoD/W7nHod
         z1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746556514; x=1747161314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UunZOaxiv1FMCIph+Y0cMA/y3FCJuA3U5gYOuCj4Rc=;
        b=OOXdPVtiHsT2k+C2MFL02Yk/mlK21PToAJrIrb2bNPfXCmCVDBcMSh0M0iQdCJaSrK
         Q8QAaB/GS+apHo9k7xvJoHd2rQPJp7N1agcGWQ2z423s/1bL0Ss8yV+cXgopoI9RnhRc
         YJ2FMQmFqf6Jn2xOsyOpPg+S09SPs9+mxwqfSRlilBPqv9Z30RUPhqFesQiqv/9uNmvt
         7EHavchWxc0iulC3d0QyvWc9s9CvtodoVD2uNojOEp8oIwFjHo965N4Q67ljg49sTi7C
         aCOSoGJL1FmS7hoJnjK3AxDMzwv3Lo1S3gWOHIEEBOwkCyNCRZUBHqweVDxa4lxR9yTS
         VTNQ==
X-Gm-Message-State: AOJu0YwpyzykHHPfmLxlYRI76hn7i9KVDXTnI3I1erQeMpZFtPVannmc
	/CAK3Nrq7wbQz7r4viM+wrwlQTYQ06pM2fg9/52Zd7J8mBgdEN1VVnfOjwUm/LwezZBFAapc2Cz
	a
X-Gm-Gg: ASbGncs3sBCcNYarbo2/7P8y6eObm+7CnAaOudrWouzDL9Cq42740V1Sd+R58Elbn5F
	NgDlumWkANZ+ftFgRFvuHLIWD/zQORqftakn+POangF14JhMspwcY5oMb6ZSoCxvOinjVYO44NT
	PB3mqmWBYPmqU+DPSneYl5EHDfg5H55eoQSLhZajr9SxO+NcKvffsIvdiDTQjyh/2ebbJqsnRzB
	J/XWGH6xbolPIR3/Z8/gOfsxPrUXR2iPEQ1RIsKfOMB2qcEDP93FOI5DKYO2tU1n/8XKWNGeVbb
	0LyysOLvkRkXsx8KMA4AkWaNOcl4AkNDxA9TzV834g1Ivw==
X-Google-Smtp-Source: AGHT+IHoZ6D+Z+zaSuh8owCDu+P93h+8Llc4Q/wu0O7BCian50cNH27RiPeikmMlRPJiWBCUO8vX+g==
X-Received: by 2002:a05:6000:1acc:b0:3a0:8295:9e0f with SMTP id ffacd0b85a97d-3a0b4a186cfmr437109f8f.54.1746556513929;
        Tue, 06 May 2025 11:35:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a099ae7b09sm14301879f8f.48.2025.05.06.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 11:35:13 -0700 (PDT)
Date: Tue, 6 May 2025 21:35:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <aBpWXB8c8RSjYBtD@stanley.mountain>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>

On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
> On 5/6/25 7:32 AM, Dan Carpenter wrote:
> > Hello David Lechner,
> > 
> > Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> > from Apr 22, 2025 (linux-next), leads to the following Smatch static
> > checker warning:
> > 
> > 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
> > 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
> > 
> > drivers/iio/pressure/bmp280-core.c
> >     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >     1226 {
> >     1227         struct iio_poll_func *pf = p;
> >     1228         struct iio_dev *indio_dev = pf->indio_dev;
> >     1229         struct bmp280_data *data = iio_priv(indio_dev);
> >     1230         u32 adc_temp, adc_press, adc_humidity;
> >     1231         s32 t_fine;
> >     1232         struct {
> >     1233                 u32 comp_press;
> >     1234                 s32 comp_temp;
> >     1235                 u32 comp_humidity;
> >     1236                 aligned_s64 timestamp;
> > 
> > There is a 4 byte hole between comp_humidity and timestamp.
> 
> Yes, this was the intention of this patch.
> 
> > 
> >     1237         } buffer;
> >     1238         int ret;
> >     1239 
> 
> ...
> 
> >     1279 
> > --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> >                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> > So I believe it leads to an information leaks here.
> 
> Aha, so we should e.g. do memset() to fill the hole first.
> 

That works, or you could initialize it with = { }.

regards,
dan carpenter


