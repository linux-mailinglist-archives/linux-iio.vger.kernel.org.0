Return-Path: <linux-iio+bounces-20867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99850AE306D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80023B004E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DF1E520E;
	Sun, 22 Jun 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJkISHCU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F9199938;
	Sun, 22 Jun 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602872; cv=none; b=QZgb848atgro/lFgMkzH/Cm3k1nzNPmJ/CFkwLpQDwoqfzX/fP1R4yXdXTS8TgdVSP7uYhuc6aSrYJCcxI4PMQAcYol4ZA+H7J4AGnXB/dGn3DegygKv9lZUkveYdqHAuFt16So65aE/YhbJvHcGw+tBmrBHg9Oa5zyxMPJOtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602872; c=relaxed/simple;
	bh=jG9L5HupSMKFB+jMUp23bNVdUHVrLZlMxb/cQS4aIP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG2gzl6nePNAw0I9h172AlzsSBaTRVk8pEk2uMf9rO1uUo9YYu2ot6fnwDfdA3lfY/341l5LZsWvue9gB5jLwUSzdn4H7Hr08GvY9vBbO69v/LSAdlMG92P0VsAyS1apRk/0X8WNW9Wm/yOkP2GXRB2SZTk8/M2lr9Fee9slQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJkISHCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A6DC4CEE3;
	Sun, 22 Jun 2025 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602871;
	bh=jG9L5HupSMKFB+jMUp23bNVdUHVrLZlMxb/cQS4aIP8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GJkISHCUCElw0OUt2CVpnild0Aywib07HFPVD1Kd6+RklgSZKAFDiyGGcKU9Zbz+L
	 hq+V5r+g6e6gHtbVkqb9sSD6tDN9HHLIQ2m3eAokdnKAkeGtzsYRHUpUBeqquK0KdS
	 iobZCU/X1EdItALo0pgNuphOCql2X0/ldg2Rv176GdtXtaGp3za7dBYxq+Z/mSkNVD
	 EkfGwUgTj9HYYhAMOpulYqB7NLujqF5JM40hzpW0lccByfb6+JipM+2y4ieB6K30aY
	 36BSxreEBcu2t9dnTf7mTXcOIdvWU3ojyX27TLIedcvzfTGzrkwRaJGX92aOuDpL/C
	 VLBetUlunV1mg==
Date: Sun, 22 Jun 2025 15:34:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <20250622153423.0d8ddcdb@jic23-huawei>
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 12:29:29 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The patch set covers the following topics:
> - add debug register and regmap cache
> - prepare iio channel scan_type and scan_index
> - prepare interrupt handling
> - implement fifo with watermark
> - add activity/inactivity together with auto-sleep with link bit
> - add ac coupled activity/inactivity, integrate with auto-sleep and link bit
> - documentation
> 
> Sorry for the fuzz: when I was about to rebase for submitting I
> noticed Jonathan actually already applied parts of this. I'd recommend
> to consider v6 rather over v5.
> 
> Since activity and inactivity here are implemented covering all axis, I
> assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
> channel for activity/inactiviy. AC-coupling is similar to other Analog Device
> accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
> documented and functionality tested and verified working.
> 
Given reply to wrong email thread probably meant first few patches of v5 that
I picked up, I've dropped them for now.

Thanks,

J
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> v5 -> v6:
> - `adxl313_core_probe()`: change conditional logic for evaluation of
>   `int_line`
> - `adxl313_core_probe()`: add helper function `_get_int_type()` to simplify
>   logic
> - `adxl313_is_act_inact_en()`: remove blank line; make variable `axis_en` a
>   bool
> - `adxl313_is_act_inact_ac()`: removal of ',' in comment
> - `adxl313_set_act_inact_linkbit()`: regroup logic expressions
> - `adxl313_set_act_inact_en()`: change comment style, and rephrase
> - `adxl313_read/write_mag_config()`, `adxl313_read/write_mag_value()` and
>   `_adxl313_read/write_mag_value()`: avoid nested switch/case statements,
>   add helper functions from start and populate them incrementallay
> - `adxl313_set_act_inact_ac()`: move AC-coupling code into a separate
>   helper
> - [PATCH v5 1/8], [PATCH v5 2/8], [PATCH v5 6/8] and [PATCH v5 8/8]: set
>   "Reviewed-by:.."
> 
> v4 -> v5:
> - [v4 01/11]: applied - debug register                                          
> - [v4 03/11]: applied w/ changed commit message - regmap cache                  
> - refrase all commit messages                                                   
> - merge patches [v4 02/11] [v4 05/11] and [v4 06/11]                            
> - add ADXL313_REG_INT_SOURCE to the initial regmap cache definition             
> - `adxl313_set_watermark()`: replace plain hex numbers by defined bit masks     
> - `adxl313_set_watermark()`: replace `regmap_update_bits()` by
>   `regmap_set_bits()`
> - `adxl313_get_samples()`: remove initialization of variable `samples`          
> - `adxl313_buffer_postenable()`: add comment on turning off measurment          
> - `adxl313_push_event()`: move WATERMARK separate out, focus on pushing events  
> - `adxl313_irq_handler()`: add comment on draining the FIFO                     
> - `adxl313_push_event()`: remove missleading comment on return statement        
> - `adxl313_is_act_inact_en()`: If it's false, it will be false anyway -
>   simplified now
> - change order in multiplication with unit: `val * MICRO` which is read
>   more naturally
> - `adxl313_is_act_inact_en()`: remove check for ADXL313_ACTIVITY in the
>   activity patch
> - `adxl313_write_event_value()`: remove the general turning off measurement mode
> - `adxl313_set_inact_time_s()`: replace plain number 255 by U8_MAX              
> - `adxl313_read/write_event_config()`: encapsulate duplicate code into
>   `adxl313_read/write_mag_config()`
> - `adxl313_read/write_event_value()`: encapsulate duplicate code into
>   `adxl313_read/write_mag_value()`
> - `adxl313_is_act_inact_en()`: apply switch/case rather than if/else for
>   readability; factor out variable `coupling`; convert all remaining `_en`
>   variables there to bool, such that a negative error is evaluated from a
>   `ret`, and     logic operates with `_en` variables
> - `adxl313_set_act_inact_en()`: major rework due to issues discovered by
>   automated testing (also affects related functions)
> - fix kernel-doc issues 
> 
> v3 -> v4:
> - squash patches [v3 02/12 + 03/12]: buffer usage into the patch that adds buffered support
> - squash patches [v3 07/12 + 08/12]: interrupt handler with watermark implementation
> - add patch: (in)activity / AC coupled as `MAG_ADAPTIVE` event
> - `ADXL313_MEASUREMENT_MODE`: adjust commit message on removal of define and adding measurement enable function
> - remove irq variable from driver data struct, make it a local variable
> - `adxl313_core_probe()`: flip logic to condition `int_line != ADXL313_INT_NONE`
> - `adxl313_core_probe()`: change mapping interrupts from 0xff to an explicit local mask
> - `adxl313_core_probe()`: add comment on FIFO bypass mode
> - reduce odd selection of headers to add [`adxl313_core.c`]
> - `adxl313_set_fifo()`: this function was turning measurement off/on before changing `fifo_mode`,
>    called in postenable and predisable this firstly excluded setting of interrupts, and secondly
>    still configured watermark where unnecessary, this function was thus removed (covers unhandled
>    return value, and refactoring of function parameters)
> - `adxl313_fifo_transfer()`: simplify computation of `sizeof(i*count/2)`
> - `adxl313_irq_handler()`: make call of `adxl313_reset_fifo()` conditional to OVERRUN one patch earlier
> - includes: rework adding included headers
> - activity: change to work with or'd axis and related changes to the fake channel and arrays
> - `adxl313_set_act_inact_en()`: generally turn off measurement when adjusting config
>   activity/inactivity related config registers, turn measurement on after
> - doc: adjust code block highlighting and remove links
> 
> v2 -> v3:
> - verify keeping trailing comma when it's multi-line assignment [v1 02/12]
> - `adxl313_set_fifo()`: verify have two on one line to make it easier to read [v1 07/12]
> - `adxl313_fifo_transfer()`: verify removal of useless initialization of ret [v1 07/12]
> - `adxl313_fifo_transfer()`: verify usage of array_size() from overflow.h [v1 07/12]
> - `adxl313_fifo_transfer()`: verify return 0 here [v1 07/12]
> - `adxl313_irq_handler()`: verify "Why do we need the label?" / moving the call under the conditional [v1 07/12]
> - verify reorganization of half condition for Activity [v1 09/12] and Inactivity [v1 10/12]
> - verify usage of MICRO instead of 1000000
> - `adxl313_is_act_inact_en()`: restructure according to return logic value, or negative error
> - `adxl313_set_act_inact_en()`: restructure function, use regmap_assign_bits()
> - `adxl313_set_act_inact_en()`: verify makeing it a logical split [v1 11/12]
> - `adxl313_fifo_transfer()`: change iterator variable type from int to unsigned int [v2 07/12]
> - `adxl313_fifo_reset()`: add comment on why reset status registers does not do error check ("At least comment...") [v2 07/12]
> - `adxl313_fifo_push()`: change iterator variable from int to unsigned int [v2 08/12]
> - `adxl313_fifo_push()`: remove duplicate check for samples being <0 [v2 08/12]
> - apply `regmap_assign_bits()` in several places to replace regmap_update_bits() depending on bools
> - `adxl313_set_watermark()`: rename mask variable to make it more comprehensive
> - removal of duplicate blanks in various places (sry, my keyboard died) [v1 07/12]
> 
> v1 -> v2:
> - usage of units.h
> - simplify approach for return values
> ---
> 
> Lothar Rubusch (8):
>   iio: accel: adxl313: make use of regmap cache
>   iio: accel: adxl313: add function to enable measurement
>   iio: accel: adxl313: add buffered FIFO watermark with interrupt
>     handling
>   iio: accel: adxl313: add activity sensing
>   iio: accel: adxl313: add inactivity sensing
>   iio: accel: adxl313: implement power-save on inactivity
>   iio: accel: adxl313: add AC coupled activity/inactivity events
>   docs: iio: add ADXL313 accelerometer
> 
>  Documentation/iio/adxl313.rst    | 289 ++++++++++
>  Documentation/iio/index.rst      |   1 +
>  drivers/iio/accel/adxl313.h      |  33 +-
>  drivers/iio/accel/adxl313_core.c | 937 ++++++++++++++++++++++++++++++-
>  drivers/iio/accel/adxl313_i2c.c  |   6 +
>  drivers/iio/accel/adxl313_spi.c  |   6 +
>  6 files changed, 1261 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/iio/adxl313.rst
> 
> 
> base-commit: d1584d12ec8c35534172882c1713947110564e4c
> prerequisite-patch-id: 263cdbf28524f1edc96717db1461d7a4be2319c2


