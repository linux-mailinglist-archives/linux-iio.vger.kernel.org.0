Return-Path: <linux-iio+bounces-22936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B459BB2AFE6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540C31B2540C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B126A1AF;
	Mon, 18 Aug 2025 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEln5zqR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9D25F7A7;
	Mon, 18 Aug 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540214; cv=none; b=pfX+O8UpEDHaKpnMZ9JaV2x7hi5NHu2t4blazUa2AVO1ltaGR/cpavnF5fMV+hBhDWSDf1Z1Zi5Ie3V/nfUeEW0EfvrK1cDNu6rBIj0MI9zslEJNerZsbzns2DyjlcWdBN4D4SY+d0E+1Cq4OxU+NE3f8/OevG6ZVLKFLqSt4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540214; c=relaxed/simple;
	bh=GvblV5SwQz9OeRdLWPDs8JbZ/Ug/XvPqiWwCMhLT2pE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP8h+rRP0C4x1F93RSMsdW8A3kAKX+89tse6YsEGtuoPenitkXEVVVFhSH60SBDOoO8TmqMCJOMkh4cKOifgioOkTW0arIXEb2KOL6mJ3JdwzeyqUdfwOgpTTMHOBNIYviC25zph1/UiSVjjZO5X4E9ixo1DYWxRhBfNyLlJ5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEln5zqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A09CC4CEEB;
	Mon, 18 Aug 2025 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540213;
	bh=GvblV5SwQz9OeRdLWPDs8JbZ/Ug/XvPqiWwCMhLT2pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEln5zqRZNfaSyLeaLVBRHjJctLwbcOzfnWAS9yI5MVs3EdSvWLtJE1x0ThllOyzL
	 ZSOkmWk6Fy8JVVwnvqoAgAqhjaChlZqUsjo2cZqrQM/z2jUrv5Kp/cBxYXOTlYkqQB
	 ctCt7O2U/ivg3J+u42UEq5UbW2GFx+B3pzNLD15tbA7jADEJVaEFaSkPc46uABiWJo
	 OhnIBire7BzNl+YiQuW+kd1TjC4BxVzEcybsk3O7KOzcCjXQI06AhGsuaLWSgVebqT
	 e+69ldA8w8yx+lEGW7s9JolWQnQtnv1QCeC/h4oqxQEOR8dTr0eMHh4H54W53u+eyf
	 IrRIohc3OhYMw==
Date: Mon, 18 Aug 2025 19:03:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ben Collins
 <bcollins@watter.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] iio: mcp9600: Recognize chip id for mcp9601
Message-ID: <20250818190325.23fd310c@jic23-huawei>
In-Reply-To: <20250818035953.35216-4-bcollins@kernel.org>
References: <20250818035953.35216-1-bcollins@kernel.org>
	<20250818035953.35216-4-bcollins@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 23:59:51 -0400
Ben Collins <bcollins@kernel.org> wrote:

> From: Ben Collins <bcollins@watter.com>
> 
> The current driver works with mcp9601, but emits a warning because it
> does not recognize the chip id.
> 
> MCP9601 is a superset of MCP9600. The drivers works without changes
> on this chipset.
> 
> However, the 9601 chip supports open/closed-circuit detection if wired
> properly, so we'll need to be able to differentiate between them.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>

Hi Ben

One minor thing inline that need fixing up.

> diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> index 40906bb200ec9..54de38a39292e 100644
> --- a/drivers/iio/temperature/mcp9600.c
> +++ b/drivers/iio/temperature/mcp9600.c
> @@ -42,6 +42,7 @@

> @@ -416,16 +422,33 @@ static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
>  
>  static int mcp9600_probe(struct i2c_client *client)
>  {
> +	const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
>  	struct iio_dev *indio_dev;
>  	struct mcp9600_data *data;
> -	int ret, ch_sel;
> +	int ch_sel, dev_id, ret;
> +
> +	if (chip_info == NULL)
> +		return dev_err_probe(&client->dev, -EINVAL,
> +                                     "No chip-info found for device\n");

This line seems to be indented with spaces, not tabs then spaces which
is the coding style. I only noticed because of the shift seen in this reply.



> +
> +	dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> +	if (dev_id < 0)
> +		return dev_err_probe(&client->dev, dev_id,
> +				     "Failed to read device ID\n");
> +
> +	switch (dev_id) {
> +	case MCP9600_DEVICE_ID_MCP9600:
> +	case MCP9600_DEVICE_ID_MCP9601:
> +		if (dev_id != chip_info->chip_id)
> +			dev_warn(&client->dev,
> +				 "Expected id %02x, but device responded with %02x\n",
> +				 chip_info->chip_id, dev_id);
> +		break;
>  
> -	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
> -	if (ret < 0)
> -		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
> -	if (ret != MCP9600_DEVICE_ID_MCP9600)
> -		dev_warn(&client->dev, "Expected ID %x, got %x\n",
> -				MCP9600_DEVICE_ID_MCP9600, ret);
> +	default:
> +		dev_warn(&client->dev, "Unknown id %x, using %x\n", dev_id,
> +			 chip_info->chip_id);
> +	}


