Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7519187C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHRRvo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 13:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRRvo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 13:51:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E4B2086C;
        Sun, 18 Aug 2019 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566150703;
        bh=UTnxsogf6U3GndsH5qbgBJpPVbBOZOlAaO6r/pGjlH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=apYgLycjjKuMrJIC61LD+i3fmheU2LYKz6PMCKjkYv3RdIfTfeXrG/IbLHTXR3y7e
         Bi7XaMmkJqe1nWkJ6KRJd42u+NZ1fzIVmR2qnHDedqdY8WDMY26b4PhRpv5LaxwcY9
         m4pRKqGau8ekQwUL4SPV7pPkNkHk6g/5dT/BQ2O4=
Date:   Sun, 18 Aug 2019 18:51:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk1013: Improve comments on KIOX010A and
 KIOX020A ACPI ids
Message-ID: <20190818185139.7def1a21@archlinux>
In-Reply-To: <20190818112306.21236-1-hdegoede@redhat.com>
References: <20190818112306.21236-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Aug 2019 13:23:06 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The KIOX010A and KIOX020A ACPI ids go hand in hand, they are used in
> yoga style 2-in-1s, with KIOX010A indicating the KXCJ91008 sensor in the
> display of the 2-in-1 and KIOX020A indicating the KXCJ91008 sensor in the
> base.
> 
> Improve the existing comment on the "KIOX010A" kx_acpi_match table entry
> to make clear we are talking about a yoga-style (360 degree hinges) device
> here and add a similar comment to the "KIOX020A" entry.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to the togreg branch of iio.git and pushed out as testing to be
ignored by the autobuilders.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 6645771aa349..fee535d6e45b 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1486,8 +1486,8 @@ static const struct acpi_device_id kx_acpi_match[] = {
>  	{"KIOX0008", KXCJ91008},
>  	{"KIOX0009", KXTJ21009},
>  	{"KIOX000A", KXCJ91008},
> -	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
> -	{"KIOX020A", KXCJ91008},
> +	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
> +	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
>  	{"KXTJ1009", KXTJ21009},
>  	{"KXJ2109",  KXTJ21009},
>  	{"SMO8500",  KXCJ91008},

