Return-Path: <linux-iio+bounces-13833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB0B9FDAD1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439CE161363
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD5161310;
	Sat, 28 Dec 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhL8auyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841567A0D;
	Sat, 28 Dec 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735394056; cv=none; b=H18rsaRWcB+5hwe2VVP/4ZYmtGkmm03MNT/+YZ0TkmDCt3JaHmXjwd1lxxgcD38LIBs6l+hMk8EhJrfXuq3pens6k6qAvm/jI5SUXHxTKUeP2tJ630HjxozWQwklExjI+bw6caKus5modzW/bSOx+xrVvvCViocgbPBOErUy7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735394056; c=relaxed/simple;
	bh=EjYxsI9zm7IuhTgdFaBtMJnZCnKJA/lecoYQugy0Uzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/vJnK1JrG/G/bDapZi5EIggPSUyEYdXginxjyMYHslkGWtKOlOXKO/5H0LNrSXUghUMeLzMpwoDwS+2BWBwuA10TBeeq6zJDMxq5uJQXx2j12P+e9RNNe3d8W2Omf8sP43lRNuRW/8KVv2WU7nGSazR+Ao7wfMuEuERW1J50II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhL8auyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE62DC4CECD;
	Sat, 28 Dec 2024 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735394056;
	bh=EjYxsI9zm7IuhTgdFaBtMJnZCnKJA/lecoYQugy0Uzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UhL8auyZ/19r4DFpIZ8CileA+OCUwleLlxwJC4a132NQ3PK6bTSGMz5eqWrnSrkkK
	 +gHr0VByi/zmwSs6L9h7UspIyv8AfrwpF1ZK9Lkx42iZlk131mOzASTfN59Y+63j3x
	 dWcp4BwhKiJd9uaYv4HdB1RN/aMynvZ4dSKkFbGG24Lyka7omQupp2yYi2VRCaBecn
	 mi2myNNKeaxnw60U3Kumv8xk2cfD0uCltrqcIcMgohhji6Z33PqCKrDBugj/NDkMtL
	 YIUPUJjJFGOACELnNvMXcKKtel4v5uDBahbNdbEeiJOEdnMW68fyc/9ht5NzRjeoKv
	 Do/Ktn2N6/ReQ==
Date: Sat, 28 Dec 2024 13:54:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lanzano.alex@gmail.com, jagathjog1996@gmail.com, trabarni@gmail.com,
 danila@jiaxyga.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] dt-bindings: iio: imu: add missing property type
Message-ID: <20241228135405.0e3aafef@jic23-huawei>
In-Reply-To: <20241225-economy-jailbird-b798ef7f50c4@spud>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
	<20241225-economy-jailbird-b798ef7f50c4@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 14:23:34 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Dec 20, 2024 at 12:47:42AM +0100, Vasileios Amoiridis wrote:
> > It seems that some drivers miss the "type: boolean" under the
> > drive-open-drain property, so add it.
> > 
> > Vasileios Amoiridis (3):
> >   dt-bindings: iio: imu: bmi160: add boolean type for drive-open-drain
> >   dt-bindings: iio: imu: bmi270: add boolean type for drive-open-drain
> >   dt-bindings: iio: imu: bmi323: add boolean type for drive-open-drain  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to probably ignore these.

Thanks,

Jonathan

