Return-Path: <linux-iio+bounces-10252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FB3991EDB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702E01C20F5D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1446CDBA;
	Sun,  6 Oct 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGD1UZvC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F143482EF;
	Sun,  6 Oct 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224608; cv=none; b=dWnkhAG+fIjK/sf41B9GMsSVI2ScnFhgSXi3tJYsrrFdSsjnTHppV4QN9+e9fPubd169VnBslsMLUm/dqzOE4xUDTeFWBernRWhP6Q8lEzHEGkXQ1VZ7KtdFpyRlfpeD/skPpiV2Oe/cW/MZepHbSlq8nsYF8jWi3EGcsyDlXSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224608; c=relaxed/simple;
	bh=CNkPGnoTVRaYye84kjCIZIAeaNWed4UNi5HlPAGQgLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGr+tddi4YwiZkNshSmOKOn8el59BPprSm7usG4VZ8v9S0WqyRY0dlHs+AgD2AG01fuG1z8W0cIPR9cTDseFxtdoMW03yMFTAqyqFixZ0gbLMCRLrNWiyc5ZZK6ZqXgHkt54cigknJqqftet4CEc33dtUViVkJrdxxQ+ex+k8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGD1UZvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F713C4CEC5;
	Sun,  6 Oct 2024 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728224608;
	bh=CNkPGnoTVRaYye84kjCIZIAeaNWed4UNi5HlPAGQgLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGD1UZvCs0T8XkCGFmHWSbG34X9W+pdAFS6oGpIbBA3nW7lFhSApjJ5W4XQKzp6l7
	 fyZZrw9wKdW6VXyx+EETWNKoove6bSwJQvGJ0S7vkcdylNTQNHqJMw8BeBuzFZyC0R
	 CCGOwlWDaz/QGzyahjrZkJAprWPePVFPi4x5NLb0fkeEr50nmyxBf3fARgoG68QTGd
	 jAL3SgH1zEFl7UCIggEqyHmKVxH6vgjc9RKHf0FJuTGYk2zOutEHuf6n3SOi347Zel
	 SdrdcWZ2ZALZ7mga3nQTI2FGksadU3MvxG1Ok2NcWCYje/KKHsMqdIPjIbmSpXI5Kn
	 97Rh2ISZgneJg==
Date: Sun, 6 Oct 2024 15:23:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: fix possible race condition during access of
 available info lists
Message-ID: <20241006152253.062b9cc5@jic23-huawei>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:34:05 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Some iio drivers currently share an available info list buffer that
> might be changed while iio core prints it to sysfs. This could cause the
> buffer shared with iio core to be corrupted. However, note that I was
> able to trigger the race condition only by adding a delay between each
> sysfs_emit_at calls in the iio_format_list() to force the concurrent
> access to the shared available list buffer.
> 
> This patch set extends the iio APIs and fixes some affected drivers.
Thanks for tidying these up.  My comments are very minor but
as this is changing how a core bit of infrastructure works I'd like
them to sit on the list another week anyway.

There is just enough here that I'd prefer a v2 though if you don't
get time I can probably tidy it up whilst applying.

The build bot issue is presumably a missing include.

Thanks,

Jonathan

> 
> Summary:
> - Patch 1: iio core: introduce a iio info release callback to let
>   drivers share a copy of their available info list and later free it.
> 
> - Patch 2: pac1921: handle the current scale available info via the
>   read_avail+read_avail_release_resource APIs instead of using an ad-hoc
>   ext_info attribute. The latter was used to avoid the risk of a race in
>   the available list.
> 
> - Patch 3,4: ad7192, as73211: fix the possible race in the drivers by
>   copying/releasing the affected available lists.
> 
> - Patch 5: inkern: make consumers copy and release the available info
>   lists of their producers, necessary after patch 1.
> 
> - Patch 6,7: iio-mux, iio-rescale, dpot-dac, ingenic-battery: adapt
>   consumers to inkern API change by freeing the now copied available
>   lists of their producers.
> 
> Tested:
> - pac1921: could not reproduce the race condition with the new APIs,
>   even with additional delays among the sysfs_emit_at calls during a
>   shunt resistor write. No new issue found after the change.
> 
> - iio-mux, iio-rescale, dpot-dac: tested with pac1921 as producer, which
>   was adapted to produce a mock raw available info list.
>   The tests did not cover the driver features but focused on assessing
>   the function call sequence. For example the following traced function
>   graph shows a read of the dpot mocked out voltage (with ftrace
>   filters: pac1921* iio* dpot* kmemdup_array* kfree*):
> 
>  3)               |  iio_read_channel_info_avail [industrialio]() {
>  3)               |    dpot_dac_read_avail [dpot_dac]() {
>  3)               |      iio_read_avail_channel_raw [industrialio]() {
>  3)               |        iio_channel_read_avail [industrialio]() {
>  3)               |          pac1921_read_avail [pac1921]() {
>  3)   5.208 us    |            kmemdup_array();
>  3) + 11.459 us   |          }
>  3)   3.167 us    |          kmemdup_array();
>  3)               |          pac1921_read_avail_release_res [pac1921]() {
>  3)   1.709 us    |            kfree();
>  3)   4.458 us    |          }
>  3) + 25.750 us   |        }
>  3) + 31.792 us   |      }
>  3) + 35.000 us   |    }
>  3) + 37.083 us   |    iio_format_list [industrialio]();
>  3)               |    dpot_dac_read_avail_release_res [dpot_dac]() {
>  3)   1.583 us    |      kfree();
>  3)   4.250 us    |    }
>  3) + 84.292 us   |  }
> 
> - ingenic-battery: also tested with mock available info produced by the
>   pac1921 driver. Following the traced graph part that should correspond
>   to the ingenic_battery_set_scale() flow (which is not traceable with
>   the additional ingenic* ftrace filter for some reason):
> 
>  2)               |  ingenic_battery_probe [ingenic_battery]() {
>                 ...
>  2)               |    iio_read_max_channel_raw [industrialio]() {
>  2)               |      iio_channel_read_avail [industrialio]() {
>  2)               |        pac1921_read_avail [pac1921]() {
>  2)   4.333 us    |          kmemdup_array();
>  2) + 10.834 us   |        }
>  2)   3.500 us    |        kmemdup_array();
>  2)               |        pac1921_read_avail_release_res [pac1921]() {
>  2)   1.791 us    |          kfree();
>  2)   4.625 us    |        }
>  2) + 26.291 us   |      }
>  2)   1.583 us    |      kfree();
>  2) + 35.750 us   |    }
>  2)               |    iio_read_avail_channel_attribute [industrialio]() {
>  2)               |      iio_channel_read_avail [industrialio]() {
>  2)               |        pac1921_read_avail [pac1921]() {
>  2)   3.250 us    |          kmemdup_array();
>  2)   8.209 us    |        }
>  2)   3.458 us    |        kmemdup_array();
>  2)               |        pac1921_read_avail_release_res [pac1921]() {
>  2)   1.542 us    |          kfree();
>  2)   4.292 us    |        }
>  2) + 21.417 us   |      }
>  2) + 26.333 us   |    }
>  2)               |    iio_write_channel_attribute [industrialio]() {
>  2)   4.375 us    |      pac1921_write_raw [pac1921]();
>  2)   9.625 us    |    }
>  2)   1.666 us    |    kfree();
>  2) * 47810.08 us |  }
> 
> Not tested:
> - ad7192, as73211
> 
> Link: https://lore.kernel.org/linux-iio/20240724-iio-pac1921-v4-0-723698e903a3@gmail.com/
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
> Matteo Martelli (7):
>       iio: core: add read_avail_release_resource callback to fix race
>       iio: pac1921: use read_avail+release APIs instead of custom ext_info
>       iio: ad7192: copy/release available filter frequencies to fix race
>       iio: as73211: copy/release available integration times to fix race
>       iio: inkern: copy/release available info from producer
>       iio: consumers: release available info buffer copied from producer
>       power: supply: ingenic-battery: free scale buffer after use
> 
>  drivers/iio/adc/ad7192.c               |  22 +++++-
>  drivers/iio/adc/pac1921.c              | 128 ++++++++++++---------------------
>  drivers/iio/afe/iio-rescale.c          |   8 +++
>  drivers/iio/dac/dpot-dac.c             |   8 +++
>  drivers/iio/industrialio-core.c        |  14 +++-
>  drivers/iio/inkern.c                   |  64 ++++++++++++-----
>  drivers/iio/light/as73211.c            |  23 +++++-
>  drivers/iio/multiplexer/iio-mux.c      |   8 +++
>  drivers/power/supply/ingenic-battery.c |  16 +++--
>  include/linux/iio/consumer.h           |   4 +-
>  include/linux/iio/iio.h                |   4 ++
>  11 files changed, 185 insertions(+), 114 deletions(-)
> ---
> base-commit: fec496684388685647652ab4213454fbabdab099
> change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98
> 
> Best regards,


