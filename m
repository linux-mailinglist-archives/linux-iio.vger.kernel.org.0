Return-Path: <linux-iio+bounces-19858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49709AC336E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCB018965F6
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFF143895;
	Sun, 25 May 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9cWX7dc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6042AA5
	for <linux-iio@vger.kernel.org>; Sun, 25 May 2025 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165593; cv=none; b=QpxU/ZbzhozBCKnklaHvMTo2sfSqh/YrgTF+uMtm96l7NjEMA5blZYoB9PTjZbe0CQYActuG3C35SXzTa6VaLOFoa78Xojuqfi2l63AvAbb0fPKz7C6pQa6UYBg7S0NT0AsP8vakT0UwDD+7vQ+TNedD9dcNV8D3ZgFg13mkaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165593; c=relaxed/simple;
	bh=+wzh/vGkXe/frL37fuMnqEiv80UCrhFXpO/TDVweoWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5TTf0xrZ9DNCR1CvYHPbhcCPfn1gBCKf4Dctc0nI77OrC3zpVki6Xbg2QXnG5scf+O5Jt1IYf8VGYIuiuefbjDWSN/EQZUYePwVDBkmget/Bd6Q5Lub41ikXQDoxFdDknvrNQKFTf9GwWEFPYQH6BVJHkVKWA4TBQKyN5pWr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9cWX7dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD18C4CEEA;
	Sun, 25 May 2025 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748165592;
	bh=+wzh/vGkXe/frL37fuMnqEiv80UCrhFXpO/TDVweoWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9cWX7dc4xb8a4mw/NRyGe4aypGDr3pNVEINiIcxqiTiP38/GI1VzWo0h94P1U84n
	 S3gKwmq6yznCYEhnc5UTQEKZPuNrTUMqnfbiDis/HEks5VZ20/dD6SSWFvpwexLumP
	 v8m43OwnzxZtTxe8YZ1JrXbMLzh6UoPAARinx3D94tbzIFssaSas+qUIzs+3tlMOG1
	 xkAyn/lT0s3zbZJSUbjgC2CesiaNEw9iYN3dRDdThNUR6DKkdVLllCqh3UJTJFlwiW
	 AwUFVdzjLa0NX51q5fYavRFtsOmBwUqYQXBV11fpjJcMk0Ol2MRsKej8n1CXZOHNFu
	 6mfgj/egoATqA==
Date: Sun, 25 May 2025 10:33:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, "Derek J.
 Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>, Justin Weiss <justin@justinweiss.com>
Subject: Re: [PATCH 1/2] iio: bmi270: suspend and resume triggering on
 relevant pm operations
Message-ID: <20250525103304.65ba359d@jic23-huawei>
In-Reply-To: <cddc4a4f-f982-49ec-a03b-3e26038057fe@gmail.com>
References: <20250509171526.7842-1-benato.denis96@gmail.com>
	<20250509171526.7842-2-benato.denis96@gmail.com>
	<aCG3YRP66cKyzr1B@smile.fi.intel.com>
	<cddc4a4f-f982-49ec-a03b-3e26038057fe@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 May 2025 22:25:11 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> On 5/12/25 10:54, Andy Shevchenko wrote:
> > On Fri, May 09, 2025 at 07:15:25PM +0200, Denis Benato wrote:  
> >> Prevent triggers from stop working after the device has entered sleep:
> >> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.  
> > The cover letter call it a fix, where is the Fixes tag?  
> I didn't know if it was okay to use that tag while to root cause is still there and it needs to be fixed for a lot more devices.
> 
> I was also attempting to make this patch very similar to accepted one: https://lore.kernel.org/all/20240807185619.7261-3-benato.denis96@gmail.com/
> 
> Is fixed tag appropriate?

I think it probably is appropriate given not having a trigger restart after returning
from suspend is unlikely to be desired behaviour.

Jonathan

> 
> >
> > ...
> >  
> >> +const struct dev_pm_ops bmi270_core_pm_ops = {
> >> +	RUNTIME_PM_OPS(bmi270_core_runtime_suspend,
> >> +		       bmi270_core_runtime_resume, NULL)  
> > One line (it's only 85 characters and it's fine in this case).  
> 
> 
> Okay, will send a new version when I have answer to the above question.
> 
> 
> >> +};  
> > ...
> >  
> >> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> >> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> >> @@ -52,6 +52,7 @@ static const struct of_device_id bmi270_of_match[] = {
> >>  static struct i2c_driver bmi270_i2c_driver = {
> >>  	.driver = {
> >>  		.name = "bmi270_i2c",
> >> +		.pm = pm_ptr(&bmi270_core_pm_ops),  
> > Is pm.h included?  
> I assumed it was not needed since the i2c_driver definition should be enough.
> 
> 
> I will include pm.h on the next version, thanks.
> 
> 
> >  
> >>  		.acpi_match_table = bmi270_acpi_match,
> >>  		.of_match_table = bmi270_of_match,
> >>  	},
> >> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> >> index 88a77aba5e4f..b25171413531 100644
> >> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> >> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> >> @@ -79,6 +79,7 @@ static const struct of_device_id bmi270_of_match[] = {
> >>  static struct spi_driver bmi270_spi_driver = {
> >>  	.driver = {
> >>  		.name = "bmi270",
> >> +		.pm = pm_ptr(&bmi270_core_pm_ops),  
> > Ditto.  
> >>  		.of_match_table = bmi270_of_match,
> >>  	},
> >>  	.probe = bmi270_spi_probe,  
> I don't know how but your answer was lost in my mail.
> 
> Sorry for the late response and thank you for your suggestions,
> Denis
> 


