Return-Path: <linux-iio+bounces-18249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F20A938C7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745251B62756
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D31BF33F;
	Fri, 18 Apr 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLapG7+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2D1B5EB5
	for <linux-iio@vger.kernel.org>; Fri, 18 Apr 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987145; cv=none; b=G1SViwtEs+2RR8JjV515gonm3uYUCi/HHCCSKYs5wr/tzPfFPH+1qGV3pHMJD5BLIt8nFi3L+gOC4FUGonp5tX190Xt75RqVRY8b+zBkDpcM0aguaaSo3TW7E5GXst900DU5xMmUr/ZoDKCzd0xPUCLnfu18wYL9D4O2RN2O4uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987145; c=relaxed/simple;
	bh=szYsQw1JQm9CTNhuy1Y9B7Zk5U+Bx+exlkUjChm0+oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUWI9PSLK53yRufSVVyqehUqYO9txwjOHZ8xxVMPr7FbW5iBX8vikOgJ5sqd7qaY1pzMlsf/o9QcM6b8kws+u9ARfMhMDvvu2eRqGP89ZiIP4vv/KKO2PWqaiMQEG7t61wd2jPlYTueMuk++3yg+nIiCEvYZmW33XwgoF5SQOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLapG7+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86DBC4CEE2;
	Fri, 18 Apr 2025 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987145;
	bh=szYsQw1JQm9CTNhuy1Y9B7Zk5U+Bx+exlkUjChm0+oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLapG7+VSN2wBKkg9pnD/OzE9PchU5kV99K0Pu50zqpvOcs/ir/EUfe0KKl2dVV+V
	 c+HLD5I+/HiHmxn6YUxp+ED7u6zjwWTARQjHTqK4EzB9pvQ2o86CavOywvv8/FHehj
	 xKpVowb16l3SJeETDFWglTWzNo0RdfCGovCdfSd2mm0SVQA7W/svAm5Vu/Kr32v4kd
	 yT+B2BZgeL7O4stW/boHFs2ga1lBNBI7AT8B/Y304KEYxsI3Tgx9kRDOvh3s9FP/QA
	 FRsVW0OpSlTazgWFNfRhuBYdGwBFvJNPa3is0RUo/Gub4Cs2QCOjSOa8BOTmC5xivz
	 ZGpMHlxKpXjSA==
Date: Fri, 18 Apr 2025 15:38:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 00/20] IIO: Introduce iio_push_to_buffers_with_ts()
 taking an input buffer length argument.
Message-ID: <20250418153858.1d9284c4@jic23-huawei>
In-Reply-To: <c3058c51-a956-4f49-837b-4cc0ac7ffeb0@baylibre.com>
References: <20250413103443.2420727-1-jic23@kernel.org>
	<c3058c51-a956-4f49-837b-4cc0ac7ffeb0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:48:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/13/25 5:34 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > v3:
> > - Take the dummy driver back to doing a kzalloc()
> > - Various white space changes.
> > - Tag collection
> > v2:
> > - Add some fixes via aligned_s64 (thanks David)
> > - Improve naming of new parameter and mark the error check unlikely (thanks Nuno)
> > 
> > When using the IIO buffers, the length of each scan element is always known to
> > the IIO core (used for sizing kfifo elements etc) and depends on which channels
> > are enabled. Devices often use fixed size structures or arrays.
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied and pushed out as testing. Thanks,.

