Return-Path: <linux-iio+bounces-21181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C5CAEF49F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FA83B28A7
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79225CC4B;
	Tue,  1 Jul 2025 10:12:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164191DF73A;
	Tue,  1 Jul 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364724; cv=none; b=C/wi0m4pygKm3wCPH+0dlQr0POGJ0pAqtDNP5NPQKSf7GPgxAJy6EwJMsAJQbou5tLTqm41IAeMwCkF1QcmgXXLHsBGehABl6Msrel6X80oOr5eeq+QRfB46dxsrbZGyTXR/Gs0WOkOFdMOXU26Rzy8OWa1hbtTS5IvR6YgAjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364724; c=relaxed/simple;
	bh=OGHj409/Db6Cl5Cq6+vIVmpaMrlpw5jMV6PCvjfroBM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJP7zhqeyhecJwnnUnLcRCAe41o4ozNf4OcAqtDArXVfqz84t7jTwAYosxaCcdeN868knsSt01Rht4SqChtp3hxVQmjKl28x9JoQcN3qqWYn6O72K2pp/IjruwbX/mLGDK5HjwVV907h2Qv65kvaUcxyaSQk1XIWT0R800WWz6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWf1b6Z9Rz6M4rJ;
	Tue,  1 Jul 2025 18:10:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D86791402EA;
	Tue,  1 Jul 2025 18:11:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 12:11:53 +0200
Date: Tue, 1 Jul 2025 11:11:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
Message-ID: <20250701111151.00004167@huawei.com>
In-Reply-To: <epswbthrftxecrgm2rjkag6yxkpegr7boodzpjqfx675gghziy@p7dy7cns2ot6>
References: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
	<20250531170448.2be25330@jic23-huawei>
	<20250629171908.122a5163@jic23-huawei>
	<epswbthrftxecrgm2rjkag6yxkpegr7boodzpjqfx675gghziy@p7dy7cns2ot6>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Jun 2025 11:09:02 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
> 
> sorry, could you merge this, or do you need the hash fix ? 
> 
I fixed it up.


J

