Return-Path: <linux-iio+bounces-14490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A4A16867
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6600C7A1587
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB7194096;
	Mon, 20 Jan 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTOsgXM0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2907E1
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363053; cv=none; b=AMBVsWb3lxlWBL1hRMbYGzgZNRo8o4N13puiz6hlgHy3aCJunHYmO1/mpP4p0jDxZp1bLBsMMmvuZt59YnXA8gXx4YTiiQFAPDbKUMPojwG8tTTXm3xHb33il260WOmMlTlvWa31Foza6noqXw/zgh5+YCqeLiPLyTiylEQ8B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363053; c=relaxed/simple;
	bh=S+pXFZ8xKWd4WUKlxbF//qfOgupGr8JgOeNtTkoKhBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4LiyvMw8ZqZwqyah5qy3VMf5iHPdN/l4gMuP6lJkeGtg4W4SVBEA0Y29tgNTpzrAaZqaXdBGjTO992RGPbT9ur1lz86lClSZjNqaCdGSG/pX/aJ1YEtwcawUc4EY0mzsDqDwQEj5jGFMBIsFlf98irxnaz6eWNCCSwAX6tHd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTOsgXM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F125BC4CEE4;
	Mon, 20 Jan 2025 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737363052;
	bh=S+pXFZ8xKWd4WUKlxbF//qfOgupGr8JgOeNtTkoKhBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTOsgXM0fnDgL6mrOitfDWDLo018H6VcMxUSrhRSrnCfV548dEXi85R0hZvS92ABu
	 sE/f8q8CBsmVhKAqI8HaZC7mIFy8yA6bEBBEAegGEnnH3+P5s46eowyzkoLubprugl
	 3lMuUZmIvpANbxDKuD7MC+gU34bNKf18SZuzUWKAI4adR6yo406l40OMH1jBtCCluI
	 3QmLms9uzVvIu+HNV1G6HrIpcVPM61cNpByXYDtTRD3Rl2rSKB7mPZkmECbmKIKzGS
	 F8lAKbZ7I3fEgAlyUTBNLSgNZ14/Hw2FtJ0wae2w/A9kPfZ/2uIFc64NLBLMlDGAyj
	 vJqmLCZi17e8Q==
Date: Mon, 20 Jan 2025 08:50:49 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Trace EC sensors command
Message-ID: <Z44OaSCdFeCygJLQ@google.com>
References: <20250117230136.2237346-1-gwendal@chromium.org>
 <20250118162748.6badf0ab@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118162748.6badf0ab@jic23-huawei>

On Sat, Jan 18, 2025 at 04:33:52PM +0000, Jonathan Cameron wrote:
> I briefly applied this, but...
> 
> [jic23@jic23-huawei iio]$ make LOCALVERSION= W=1 -j12  C=1
> mkdir -p /home/jic23/src/kernel/iio/tools/objtool && make O=/home/jic23/src/kernel/iio subdir=tools/objtool --no-print-directory -C objtool 
>   CALL    scripts/checksyscalls.sh
>   INSTALL libsubcmd_headers
>   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
>   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
> In file included from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h:56,
>                  from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c:32:
> ./include/trace/define_trace.h:106:42: fatal error: ./cros_ec_sensors_trace.h: No such file or directory
>   106 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> 
> Despite dealing with trace points a lot in the day job
> I still find them hard to actually add to a subsystem because
> of fun things like this one. 

Weird, I did the same test without seeing the error:

$ make O=build_dir W=1 allmodconfig \
        drivers/iio/common/cros_ec_sensors/cros-ec-sensors-core.o
...
  CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
  CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
  LD [M]  drivers/iio/common/cros_ec_sensors/cros-ec-sensors-core.o

