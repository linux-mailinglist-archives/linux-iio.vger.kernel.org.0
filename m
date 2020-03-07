Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1017CF0A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgCGPX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgCGPX7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:23:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3019D20656;
        Sat,  7 Mar 2020 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583594638;
        bh=aCCCrUKfXxqxSeeCuhgGwXldBzBnBmy6PVnzue38apw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byShzXezRpd9w+PteREvm04Y+ywWHR91lMjGfceHaAa2VF4CHYKPqloHf749Mpiso
         e5feIdhmyyCdVCBBOQfDoQuTZFqexoyzaHhCNzO6i0HRth9+sCFoTrIW0GbSovViu+
         ZY+zBabvp1gAtEeQdt5hzfNn77govv0jo18u0tCY=
Date:   Sat, 7 Mar 2020 15:23:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add a TODO
Message-ID: <20200307152355.17334a4c@archlinux>
In-Reply-To: <5e5a7725.1c69fb81.e50cb.9224@mx.google.com>
References: <5e5a7725.1c69fb81.e50cb.9224@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Feb 2020 20:07:21 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> This patch adds a TODO file with some work items added with reference to
> the conversation in [1].
> A TODO file is immensely useful while onboarding new contributors who
> are looking for some low hanging fruit to get their foot into the door.
> Since these items affect all drivers the file has been placed in the
> root iio directory instead of augmenting the staging TODO.
> 
> Thanks,
> Rohit
> 
> [1]: https://marc.info/?l=linux-iio&m=158256721009892&w=2
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>

Hmm.  I worry a bit this will rot, but the current items are fairly
generic so fair enough.

Applied to the togreg branch of iio.git with a few tweaks as below

Thanks,

Jonathan

> ---
>  drivers/iio/TODO | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 drivers/iio/TODO
> 
> diff --git a/drivers/iio/TODO b/drivers/iio/TODO
> new file mode 100644
> index 000000000000..498f9336def0
> --- /dev/null
> +++ b/drivers/iio/TODO
> @@ -0,0 +1,26 @@
> +2020-02-29
> +
> +Documentation
> +  - Binding docs for devices that are obviously used via device
> +tree
> +  - Yaml conversions for abandoned drivers
> +  - ABI Documentation
> +  - Audit driviers/iio/staging/Documentation
> +
> +- Replace iio_dev->mlock by either a local lock or use
> +iio_claim_direct.(Requires analysis of the purpose of the lock.)
> +
> +- Converting drivers from device tree centric to more generic
> +property handlers.
> +
> +- Refactor old platform_data constructs from drivers and convert it
> +to state struct and using property handlers and readers.
> +
> +
> +ADI Drivers:
> +CC the device-drivers-devel@blackfin.uclinux.org mailing list when
> +e-mailing the normal IIO list (see below).

To keep this I'll need an ack from analog.  Not sure they really use
that domain any more!  Probably easier if I just drop it.


> +
> +Contact: Jonathan Cameron <jic23@kernel.org>.
People will get hold of me just as quickly (if not quicker) via the
mailing list so I'll drop this.

> +Mailing list: linux-iio@vger.kernel.org
> +

