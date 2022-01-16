Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8F48FE11
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiAPQ6l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 11:58:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36214 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiAPQ6l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 11:58:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 471BA60F73
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 16:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4EBC36AE9;
        Sun, 16 Jan 2022 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642352320;
        bh=GW97CtF2VdxzaGyXU6ykoqy3BulkEsvbNqedhKQomGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdUlH8nVlLmJSGoiq409KM+1+5Uvw0uGFCsjB1DB48NNQgnNfz0keTZY51XbBsf9D
         LNaY+qeDLqJBQNKBri+sn5Uq3tyb7R5PmsjK2JQuWHe6zlwdVy+qcE19Z3AAUhAfSI
         LowIdN57+luzZcStZ139YivC1WfRCMJmClDsIc2NxBCVIWnDHRzOnqvZTa2tTZM49a
         +NhZpYLkLtFfvqL1yiKSh6Ca99DyZInkIAZE510Z7YOhwGmAQ4m+xYjqr0zNbXAC/F
         RPLmPPoojaT/08SdJlgCrhPSCGsBcfNev3LV0wVPMVGPjKhZs2CtgxMi/Ln3elp9lm
         ps/llbnA6LdOw==
Date:   Sun, 16 Jan 2022 17:04:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 1/3] iio: proximity: Add sx9360 support
Message-ID: <20220116170442.17b91222@jic23-huawei>
In-Reply-To: <20220109110000.56f66c3c@jic23-huawei>
References: <20220101203800.290387-1-gwendal@chromium.org>
        <20220101203800.290387-2-gwendal@chromium.org>
        <20220109110000.56f66c3c@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Jan 2022 11:00:00 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Sat,  1 Jan 2022 12:37:58 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
> > A simplified version of SX9324, it only have one pin and
> > 2 phases (aka channels).
> > Only one event is presented.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---  
> Series applied but I got a build warning which lead me to take another look
> at he below code.

Follow up tweak like the 9324 patch this one had some {A, B } spacing so I've
changed that to { A, B }

The wonders of editing history ;)

Thanks,

Jonathan

> 
> ...
> 
> > +static int sx9360_set_samp_freq(struct sx_common_data *data,
> > +				int val, int val2)
> > +{
> > +	int ret, reg;
> > +	__be16 buf;
> > +
> > +	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
> > +	buf = cpu_to_be16(val);  
> I've changed this to cpu_to_be16(reg) which I'm assuming was the intent.
> 
> > +	mutex_lock(&data->mutex);
> > +
> > +	ret = regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
> > +				sizeof(buf));
> > +
> > +	mutex_unlock(&data->mutex);
> > +
> > +	return ret;
> > +}  

