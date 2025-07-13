Return-Path: <linux-iio+bounces-21600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3CB0313C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3221175847
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2C27877D;
	Sun, 13 Jul 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Qa+2Dy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7093223DFA;
	Sun, 13 Jul 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414236; cv=none; b=q7J47m6Y+kp0ngSipkOygH4mW6oKF9MBawT/ie4O+pF0lP4IkC5uRppKkQP6xXDBwZNr2Te/JUnKGYhUhfbgsUa9w7agn4b7MNqegythR52+KMsGEr4jGjokADkky0e6ftV2mEmcN+wK8AQW5rA5JgPRaZ3M+4eRAjCqAhIS+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414236; c=relaxed/simple;
	bh=RZqZ3e3JCJu0Ewg8LuM3+kK2oKbWALGcY1tJA+xszJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puC3dJOOQ8Kc9MJi7c+NiwINbIuzNIA/MZlzCi/ikwKVQe3T39mJFj2zP9XOQwKsWMvkK8wU3M28aJcGiLwaZ30cygXFdAmPwcrZVDQJ3sFNbu5eBF4A9YO2ZEVq95F18JwxPxBQL/tfL7arTN1H/+QJVhAkeG/AccLiGpX+W/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Qa+2Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B3C4CEE3;
	Sun, 13 Jul 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752414236;
	bh=RZqZ3e3JCJu0Ewg8LuM3+kK2oKbWALGcY1tJA+xszJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/Qa+2DyxswmiMklVO3bT0NKMztF/ukUwCna4Ux+FzjF1fd3KivqTKVjudsfkBGd0
	 izio+ZSCE6yXvKGo3W9/1hUj0qUazmTFJzzAjvsIVryKAImPDhZFO/CFQh7nP30ISu
	 /oDHWXBvVmRnLMGGvtqNalP93owFqCZSyIS2/JlLdfNlHftR8SODncwqa03UnynoxQ
	 7CLtsDBnC8kvaf/+ZJPuwPpswZFsk8Bb6aLSzERufSDgB8KU47JCaZX9qYLTJNjpzE
	 4mILq7VfWtzbZhkHyJm88YErpL2aTIF+ZWHQ4p2IkkPNL+aUJygBoQGbGdau4QoASk
	 cG0vHMancHaHA==
Date: Sun, 13 Jul 2025 14:43:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>, Julien
 Stephan <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>, Bo
 Liu <liubo03@inspur.com>, Greg KH <gregkh@linuxfoundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Sean Nyekjaer <sean@geanix.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Rayyan Ansari <rayyan@ansari.sh>, Francisco
 Henriques <franciscolealhenriques@usp.br>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/80] iio: accel: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250713144346.6fc46252@jic23-huawei>
In-Reply-To: <090c1c98-0f68-47d5-9e57-bd764b2856de@gmail.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075418.3218938-1-sakari.ailus@linux.intel.com>
	<090c1c98-0f68-47d5-9e57-bd764b2856de@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:46:12 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 04/07/2025 10:54, Sakari Ailus wrote:
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---  
> 
> Looks good to me. Just one comment (to 4 drivers) - but I'm not 
> insisting it to be addressed :)
> 
> > The cover letter of the set can be found here
> > <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> > 
> > In brief, this patch depends on PM runtime patches adding marking the last
> > busy timestamp in autosuspend related functions. The patches are here, on
> > rc2:
> > 
> >          git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >                  pm-runtime-6.17-rc1
> > 
> >   drivers/iio/accel/bmc150-accel-core.c | 1 -
> >   drivers/iio/accel/bmi088-accel-core.c | 3 ---
> >   drivers/iio/accel/fxls8962af-core.c   | 1 -
> >   drivers/iio/accel/kxcjk-1013.c        | 1 -
> >   drivers/iio/accel/kxsd9.c             | 3 ---
> >   drivers/iio/accel/mma8452.c           | 1 -
> >   drivers/iio/accel/mma9551_core.c      | 1 -
> >   drivers/iio/accel/msa311.c            | 6 ------
> >   8 files changed, 17 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index be5fbb0c5d29..f45beae83f8b 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -335,7 +335,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
> >   	if (on) {
> >   		ret = pm_runtime_resume_and_get(dev);
> >   	} else {
> > -		pm_runtime_mark_last_busy(dev);
> >   		ret = pm_runtime_put_autosuspend(dev);
> >   	}
> >     
> 
> // snip
> 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 6aefe8221296..44d770729186 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -637,7 +637,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
> >   	if (on)
> >   		ret = pm_runtime_resume_and_get(&data->client->dev);
> >   	else {
> > -		pm_runtime_mark_last_busy(&data->client->dev);
> >   		ret = pm_runtime_put_autosuspend(&data->client->dev);
> >   	}
> >   	if (ret < 0) {  
> 
> //snip
> 
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index aba444a980d9..5863478bab62 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -227,7 +227,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> >   	if (on) {
> >   		ret = pm_runtime_resume_and_get(&client->dev);
> >   	} else {
> > -		pm_runtime_mark_last_busy(&client->dev);
> >   		ret = pm_runtime_put_autosuspend(&client->dev);
> >   	}  
> 
> //snip
> 
> >   
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> > index 3e7d9b79ed0e..22768f43fd24 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -672,7 +672,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
> >   	if (on)
> >   		ret = pm_runtime_resume_and_get(&client->dev);
> >   	else {
> > -		pm_runtime_mark_last_busy(&client->dev);
> >   		ret = pm_runtime_put_autosuspend(&client->dev);
> >   	}
> >     
> 
> Do these really warrant a function? (Especially for the mma9551 where 
> the function is exported). I think it'd be fine to have the 
> pm_runtime_resume_and_get() and the pm_runtime_put_autosuspend() called 
> directly without these wrappers.

Absolutely agree that they don't.  However, I think it may make
sense to clean that up in two jumps.   This series just makes the
specific drop of the unnecessary call, next series does the refactor.
That keeps this series tightly focused on one topic.

Jonathan

> 
> Anyways, this looks good to me - thanks!
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Yours
> 	-- Matti
> 
> 
> 


