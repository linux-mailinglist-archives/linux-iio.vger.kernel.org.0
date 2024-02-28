Return-Path: <linux-iio+bounces-3175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676A86B87D
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 20:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677091C208D6
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016B5E06A;
	Wed, 28 Feb 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiJvDKER"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606415E062
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149543; cv=none; b=WoMpPLOnEYicc0Ph9wpSGSMrV7ejDeRdjUhYNYv++KKIDEOkgweYM2lU56QRrm2ERwhHDVRnDJlA7bgaEaaCB6qAljpWUztpH+GHXZ7z+wfLIjUpbuhIg7gnB2abHMB6oGojtVSjBNgynGrx9SbZn+TcAptaCBVGOFanqv0qhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149543; c=relaxed/simple;
	bh=H3NyFPQ24VrmmBNC5kA8gdca6sNFTMYMzviXeYDr9j4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MR3fKEHk2vD3z1E1wlsIXNlm69eOS/pVSUv8+nr3LnY4iXI7f7+SekzUCKvDObF5Tu/a5ZlasBu2Tn1z00DG5USBfK3kRPRq0AG88LQ8/Mh28mxrXEOcvetLwWtiFzuVuZSqF0Mj8w+66/4u91QILHTtx15u0MEBafEbZvpCeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiJvDKER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E54C433C7;
	Wed, 28 Feb 2024 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709149542;
	bh=H3NyFPQ24VrmmBNC5kA8gdca6sNFTMYMzviXeYDr9j4=;
	h=Date:From:To:Cc:Subject:From;
	b=iiJvDKERCdUYMnAKT7+JQtsMJHz69KvBKkeWQOga0zWkLn/rXUz4Egauev9ckvxb7
	 ANtg+TajEKpzi4ROurYIV0b2HmP9LvdXAurmjy3YkovHYSDqApgV0y0g2mtWM4BlEy
	 e/86gU2m7WO91K17oUAdUWXMaorN+zkTMqIaCdjYuB39FPzbqxDLME49WhVuqYwnZK
	 Y+k1kQv6quAHV/O8i5Y7QQ6qpKk2/VZOzla1L9R31JFcwgz/GabcAb1w+M6udYlpgK
	 0zs6tSp/lS/6JJ24V+XSljPqZF9uZtLLWfnGBug1pDWYsuL11zmE9AjkL3YyOJoS4G
	 VgeRiOksAiHPw==
Date: Wed, 28 Feb 2024 19:45:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: IIO : Tree juggling and end of cycle.
Message-ID: <20240228194527.6f7926c6@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi All,

End of this cycle is a bit more complex that normal so I'm doing things a little
differently. I've just split the tree into two topic branches.
These both get merged into togreg for purposes of linux-next.
i.e.

togreg-normal + togreg-cleanup = togreg

People may have noticed some push back from Linus on the more innovative
ses of the cleanup.h magic.

My plan is to send Greg two pull requests in the next few days allowing
him to decide how he wants to handle taking them and to give swift
recovery path if Linus doesn't feel comfortable with the
device_for_each_child_node_scoped() case or any of the other use we've
made of this that has come in late in the cycle.

I'm probably being over paranoid :)

Obviously it's up to Greg whether he wants to take any more pull requests!

Timing wise, Linus has hinted at a possible rc8 but if not time is tight
so even if I take stuff into my tree at this point I may not include it
in the final IIO pull requests and it may have to wait for next cycle.

There was a minor formatting warning in next today that I've fixed up,
so I'll let them soak a little longer before sending those pull requests.

Thanks,

Jonathan

