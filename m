Return-Path: <linux-iio+bounces-9814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C1988FAD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36158B215B5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228B18C3B;
	Sat, 28 Sep 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvM9lwG7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325B12B64;
	Sat, 28 Sep 2024 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533880; cv=none; b=Qo402jLxBTF6a9utdAcrZB8crajsztcxIEy84yLUXc9zDX0qttanCTk73NRop20jSQnP5o9wTXDtGms1mZpfyeDq8j6wlVriWuAoot927xVF9K1aqDTLNS5B6KucLx+JfHooz+CsNi5Q7PZUPIzSU9qyS947rEHYZu48hj6zGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533880; c=relaxed/simple;
	bh=9lKVwQf2WpmuANGyONpkEXNZ4VajdZ+h0E/qFr7Gwx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR0DpBJ9uokwgtJux7xlkqpDlME+4zsqGl9UyJwq4vwP3FkB785XaL5HEl4/yaCUsxcBkZCfg+bJDjz1ZlHFTpOh9lcDpP/pVUYnYbx9NALBKNDbIGTDsAvvrUkvDQRN5LpzfoO3qtLDup5mOiYZRT8et2zFhxtWYWhr6kB6caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvM9lwG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E05AC4CEC3;
	Sat, 28 Sep 2024 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727533880;
	bh=9lKVwQf2WpmuANGyONpkEXNZ4VajdZ+h0E/qFr7Gwx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QvM9lwG7wp82BuOQJPQ+3n2+SYQr8aDAmpjVKUShT2SkOMxDdjed1yHkD+F2R/RiB
	 mE+4GLZn2MLswFRrkjqpAw91h0TILm1EExBNuc93Io4QQCATFOR0IPIMocJjgsgSeb
	 IFFkt7P9N0GBoRxcsFAjA1D2VDoZx+AxbqN6WQ3pLIz49EYI7LNESkVFpXzv+s5vLs
	 /iHliHqfk3yPQPODYFOERSQPgKX2A06VU3E5niDdTfHQKPmJO0dagR7zR74MJiv7jW
	 2k98eoS/ERbdEtV6U+rzcXJCN6i5sq8aYG9DIWlRKG0nrKipEJo/Z+Vo8F5Re5yViZ
	 8BKH6hTkoabXA==
Date: Sat, 28 Sep 2024 15:31:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Tanislav, Cosmin"
 <Cosmin.Tanislav@analog.com>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, "Schmitt, Marcelo"
 <Marcelo.Schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, Mike
 Looijmans <mike.looijmans@topic.nl>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240928153109.52ff4c5e@jic23-huawei>
In-Reply-To: <DM6PR03MB4315306944DE2E5E8CD3B236F36A2@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
	<20240914180648.592cd69e@jic23-huawei>
	<DM6PR03MB4315306944DE2E5E8CD3B236F36A2@DM6PR03MB4315.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +
> >> +	ret = ad7779_reset(indio_dev, reset_gpio);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ad7779_powerup(st, start_gpio);
> >> +	if (ret)
> >> +		return ret;  
> >What powers the device down again if we hit an error?
> >
> >Probably need a devm_add_action_or_reset() or if it self powers down may a comment on that.  
> 
> In the powerup function there are only some register writes and the start gpio is only a synchronization pulse (perhaps the name powerup is not very appropriate), 
> would an action or reset be necessary in this case? Since the regulators are not used in the driver, should there be a function disabling them anyway?
> 
If there is nothing useful to do indeed not but when I see
a power up, I rather expect a power down.  Is there anything
that can do that or is it a case of it will go to sleep anyway
for some other reason?

Jonathan

> 
> Best Regards,
> Ramona
> 


