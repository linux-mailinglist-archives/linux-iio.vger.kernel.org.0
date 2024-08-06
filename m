Return-Path: <linux-iio+bounces-8281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A6949518
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26982857BE
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EFB57CB6;
	Tue,  6 Aug 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIEHJ8OU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BAB42AA6
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960015; cv=none; b=PIgpKJfYHIKwHjeZUI752UdC2OqWDc+J0vQD6F6AIl/wYt40gJJK/qiT1x66Dpt+g9hl5EqhzO+52qSBtlvvjpgeVCRLyppJJE3QiknLNk6qy7g0tTjb7jfJJ0RN1q4IFIgI+bGze0qz3gsYsg3zh7mJVc27oJWE8+aFs575ItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960015; c=relaxed/simple;
	bh=2SyvfDl7Dbatjmr/aTcZHa/Gt4X5cxv4Imw81QmZzNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmMEjNGjUtMZzpKtWS06dufbboeVK/Jj9NlQhiRNSrwUZbF5EmfJMKTz+fy14NgPG2smBwr5X0a3S0xFIck/ISaflK9lD3UVI9SJnVMTWqjvJUKSnLmaUOqsG8HfEsPXweQBlGQBOMAe/2qbnp6fN3sH5xlMFxof0EsrPV26BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIEHJ8OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F0BC32786;
	Tue,  6 Aug 2024 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960015;
	bh=2SyvfDl7Dbatjmr/aTcZHa/Gt4X5cxv4Imw81QmZzNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jIEHJ8OUtJxyXjW4xZmEkRyYEDntQbfZ/gtnn/IKdXQ2P4F3TGEpgsJPu2bi5kvYC
	 uU/lI3MWpabqTthJCxc4TCerCfj8MgieNpTLWg3iwYZKjr6BdiFWjFr9ZMysvuIpQ7
	 MwH5QcQNTImS+gCzcZgVmuwE5AZcAJmlq9B3wLW9eSmzEYDA84FpsSKCb2MB9fXcaR
	 Nj6YGmLfH6wIIsYT855zMiEPsZDizYdmXMpMYH23s9XjNYJ4pXWxK994la5P4QI5Re
	 06SYjW1P1R8JT/BNcCOtykxnpiKl9RGPhPbqXo/xUe5hnlsqAeEA0x49+Ob8lhL+jw
	 R5QP3yOwVTnVA==
Date: Tue, 6 Aug 2024 17:00:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Dragos
 Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/2] iio: dac: add backend debugfs direct_reg_access
Message-ID: <20240806170008.2df43580@jic23-huawei>
In-Reply-To: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
References: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Aug 2024 15:35:05 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Implement the direct_reg_access callback in the axi-dac backend driver.
> On the ad9739a frontend, call iio_backend_debugfs_add() to add the
> backend debugfs interface.
Applied.

Thanks,

Jonathan

