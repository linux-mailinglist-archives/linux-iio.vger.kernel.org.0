Return-Path: <linux-iio+bounces-11379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE39B1CDF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B2A1F216C0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0032B7E591;
	Sun, 27 Oct 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfOTdrGi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582E41C6A;
	Sun, 27 Oct 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022225; cv=none; b=cwjrwbS+OdAe+0XsQKePxvfzs4PGlHFmcdhm4T+sUppCbaMX6/U3B/JPZAShjVp0YHP3n8vzBXoCrZc5xOEcQpttLH3NftzkQHsi1X9WVXWR/U9c3aWGqEHALbniMr2+RJqiYNBX6uzi3FQZSgUCdenCskp3u6mbhBxY29/9xHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022225; c=relaxed/simple;
	bh=khE0iMXpheaDoGjI0MzSNnAbelWlhROd1bTKNOWXSMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnjsoT12JSFilBIisOOZ/BqrJEubj0dVuFb98/Lk/KrKYDxI/wRo5kEk+G5e5fuXMQVwOH2GXHPUDjaNHbsnX6toYLfEXYiFdMP+hx0Zj76qtFkn0on4i0b7Zcw/RFnlGAAgFt1DRviD+qe+iLx+USZk8Kxxwe4hrteoGBFB/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfOTdrGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D78C4CEC3;
	Sun, 27 Oct 2024 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730022225;
	bh=khE0iMXpheaDoGjI0MzSNnAbelWlhROd1bTKNOWXSMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfOTdrGij0qUEpTsOt7/zxlQiPCA94pm1mDCKDGwkpjTi2SpvIu3x8GNAeQRp17IM
	 7AvMddAhWIkMNmviG/D/PMv5S0BaHxem7hVom+74wNNL9zw7PsXNUahXvPuxnHctd8
	 R7i8K+QSFw0mCusP95NPqeA3sr6JURfraEE2d5oC6T9WoITAzOdKlMRw5IlhJojME2
	 +VHnEO+5uSwOc9buGzmdgjezgNXoAgmhLIe8dR/GN0u2wjSG9mp+fsgxuQG4Mep4LC
	 d5eI/shKD5AznnFFdiK1SvZptfVm2O77GjLfUQHvb9l+6V/eU3jFIzQ1sZVB6PXKqZ
	 jmSHB79kRxbAg==
Date: Sun, 27 Oct 2024 09:43:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iio: fix possible race condition during access
 of available info lists
Message-ID: <20241027094337.0bcd33b8@jic23-huawei>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 14:54:13 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Some iio drivers currently share an available info list buffer that
> might be changed while iio core prints it to sysfs. This could cause the
> buffer shared with iio core to be corrupted. However, note that I was
> able to trigger the race condition only by adding a delay between each
> sysfs_emit_at calls in the iio_format_list() to force the concurrent
> access to the shared available list buffer.
Hi Matteo,

Excellent work (particularly the thorough testing!)
 
I'm still a bit nervous about this set and we are late in this kernel
cycle so I'm going to queue them up for the next merge window instead of
racing them in as fixes.  We may in future want to backport to stable, but
let us give them some time to soak before such a request.

So applied to the togreg branch of iio.git and initially pushed out
as testing to let 0-day take a first look.

Thanks,

Jonathan

> 
> This patch set extends the iio APIs and fixes some affected drivers.
> 
> Summary:
> - Patch 1: iio core: introduce a iio info release callback to let
>   drivers share a copy of their available info list and later free it.
> 
> - Patch 2:
>     - inkern: make consumers copy and release the available info lists
>       of their producers, necessary after patch 1.
>     - iio-mux, iio-rescale, dpot-dac, ingenic-battery: adapt consumers
>       to inkern API change by freeing the now copied available lists of
>       their producers.
> 
> - Patch 3: pac1921: handle the current scale available info via the
>   read_avail+read_avail_release_resource APIs instead of using an ad-hoc
>   ext_info attribute. The latter was used to avoid the risk of a race in
>   the available list.
> 
> - Patch 4,5: ad7192, as73211: fix the possible race in the drivers by
>   copying/releasing the affected available lists.
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
>  2)               |    iio_read_avail_channel_attr_retvals [industrialio]() {
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
> Changes in v5:
> - Patch 2: inkern, ingenic-battery: add read_avail_retvals() helpers to
>   safely use the cleanup free pattern and update commit message accordingly.
> - Update ingenic-battery test trace log in cover letter after retest:
>   iio_read_avail_channel_attribute() -> iio_read_avail_channel_attr_retvals().
> - Link to v4: https://lore.kernel.org/r/20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com
> 
> Changes in v4:
> - Patch 2: inkern, ingenic-battery: use cleanup free instead of the
>   "goto out" pattern
> - Link to v3: https://lore.kernel.org/r/20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com
> 
> Changes in v3:
> - Rebased on top of iio-togreg
> - Squash and reorder commits to allow bisection without memleaks
> - Edit summary in cover letter to match new patch order
> - Patch 2: inkern: add comment to clarify the need of the producer's buffer copy
> - Patch 5: as73211: update comment on mutex declaration
> - Link to v2: https://lore.kernel.org/r/20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com
> 
> Changes in v2:
> - Patch 4: as73211: remove one blank line
> - Patch 6: consumers: fix typo in commit message
> - Patch 7: ingenic-battery: add missing header include
> - Link to v1: https://lore.kernel.org/r/20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com
> 
> ---
> Matteo Martelli (5):
>       iio: core: add read_avail_release_resource callback to fix race
>       iio: consumers: copy/release available info from producer to fix race
>       iio: pac1921: use read_avail+release APIs instead of custom ext_info
>       iio: ad7192: copy/release available filter frequencies to fix race
>       iio: as73211: copy/release available integration times to fix race
> 
>  drivers/iio/adc/ad7192.c               |  22 +++++-
>  drivers/iio/adc/pac1921.c              | 128 ++++++++++++---------------------
>  drivers/iio/afe/iio-rescale.c          |   8 +++
>  drivers/iio/dac/dpot-dac.c             |   8 +++
>  drivers/iio/industrialio-core.c        |  14 +++-
>  drivers/iio/inkern.c                   |  99 ++++++++++++++++++++-----
>  drivers/iio/light/as73211.c            |  25 +++++--
>  drivers/iio/multiplexer/iio-mux.c      |   8 +++
>  drivers/power/supply/ingenic-battery.c |  22 +++---
>  include/linux/iio/consumer.h           |  28 +++++++-
>  include/linux/iio/iio.h                |   4 ++
>  11 files changed, 248 insertions(+), 118 deletions(-)
> ---
> base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
> change-id: 20240802-iio-read-avail-release-cb3d2a1e1b98
> 
> Best regards,


