Return-Path: <linux-iio+bounces-15126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD13A2C74D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36A87A54F4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C7D23ED56;
	Fri,  7 Feb 2025 15:34:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E9238D30;
	Fri,  7 Feb 2025 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942461; cv=none; b=ChAKlDhLF04u3JWnYXTBlXI3jVcGVFVMCv9rL0rxyEicIfXq1aukNoM4B0q9ScIFXQ8iQBZJv10mYe9NexwtzhYf9bOiP5w67Y1IP1yW/fjTsj9K6B/G5hgHMuFBiaqZCnS1rDMq5gw9RMWctxQA/F3euuWoWt2PKWfu9GnhhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942461; c=relaxed/simple;
	bh=nP/eEfPN/bwxT5v2aRBfTgmJI439shKK8G5cUYRc3EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RevnkzkqmS3LK2mWp8TbCmIWdN0TFew7e78I6R6uYxKpDOLzBv4s+DPluNIN/SBvIhx69x4iLxBvguspFIDmoC/QN5LaCPNkca1MIWcFeXf1BbUNEGCl+YIfIiJHuYp82ll2H6SCJf6oS+gQgmLpANWo2QSwqaGmFhCqMZjHG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: X/TT5NKrToaslSelBQhr9A==
X-CSE-MsgGUID: mV1AImCQQ+yYMGCMn86yjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39740095"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39740095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:34:17 -0800
X-CSE-ConnectionGUID: VXQqLjZtSzqIIF02PqrfAg==
X-CSE-MsgGUID: 1poCM6aWQKagH+xRcoUGUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111471997"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:34:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tgQMp-000000097ct-09fa;
	Fri, 07 Feb 2025 17:34:07 +0200
Date: Fri, 7 Feb 2025 17:34:06 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
Message-ID: <Z6Yn7mJZwPXs8-MA@smile.fi.intel.com>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
 <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
 <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
 <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 07, 2025 at 09:23:56AM -0600, David Lechner wrote:
> On 2/7/25 6:17 AM, Andy Shevchenko wrote:
> > On Fri, Feb 7, 2025 at 2:15 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:

...

> >>>  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
> >>>  {
> >>> -       struct gpio_descs *gpios = ts_nbus->data;
> >>>         DECLARE_BITMAP(values, 8);
> >>>
> >>>         values[0] = byte;
> >>>
> >>> -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
> >>> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);
> >>
> >> As I said before, this is buggy code on BE64. Needs to be fixed.
> > 
> > Or isn't? Do we have a test case in bitmap for such a case?
> > 
> >>>  }
> 
> Maybe not the best style, but I don't think it is buggy. Bitmaps are always
> handled in long-sized chunks and not cast to bytes so endianness doesn't affect
> it. I didn't see an explicit test, but bitmap_read() and bitmap_write() use
> array access like this so indirectly it is being tested.

Right, the potential (and likely theoretical) issue may come if DEFINE_BITMAP()
out of a sudden will use, let's say, an array of booleans. But it wasn't my
initial complain about the code :-)

-- 
With Best Regards,
Andy Shevchenko



