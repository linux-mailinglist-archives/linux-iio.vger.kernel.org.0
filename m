Return-Path: <linux-iio+bounces-9272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7229701E9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B03B1F22CF7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356815749C;
	Sat,  7 Sep 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+zP/1Ti"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23A1BC23;
	Sat,  7 Sep 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725708079; cv=none; b=F7xA+yPhzVNyX6XYPhyrWux3QX0zRoqzX3GlvFc+ZAooD25OP1o9hq3k3rD8z829YvQFxZLaHtSz4r6n8QhUGz+/M01obwgbRpY8FYxDFw3JhIY29Fa6nRzmcSKLHzVjhNu04c99B1nHOVvQ/FujphsfljYBHHBvazUYzzKtK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725708079; c=relaxed/simple;
	bh=mEPexLC/RTXu2kbuBXDYcWJoi+AtX+Puj/Yxb3cw06g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbiAw1Ig/Xi2pSRWTni1ypOxTrdrCqd6fq4BJqcdUQ1HhNw2pJJ6eRrAnltbZk/U8TV4ypyCzg7CgAZhbPAqBkKyHD4IF3T+G+HFSKpJzh2/SVLn6ocLY0mEPQtv7nO+XyJOVUyozPq1S+e7+5m2mhi06fL3i4olpUaeWqst+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+zP/1Ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43324C4CEC5;
	Sat,  7 Sep 2024 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708079;
	bh=mEPexLC/RTXu2kbuBXDYcWJoi+AtX+Puj/Yxb3cw06g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+zP/1Ti2PpOL40OSqDb98AHTPRT6nvY7zW4WvjO50bT6FCqP+eN11FcLcwTEbgml
	 js+4yDq3dAy7Hpibwfb/XOLMxxk8O4JRBpeu44wyYhc4RIyULxTlfykTx5WEP3OCYw
	 y7BXG/mjeED/Bd/AZS8xFo+gDy7WHMFPqiUYK6M1CdJdfa8M8XaxXe2zEbzACxqKXt
	 pQkKwuhVynQx8HzL4oGZiskgXOBbsZ38GXjOzblX96AbyE0pvuTj8sB3f5ZUle9IE3
	 Ng/FNoVZFYY/ye6lqsDjjQpETkCbC3klCF5eIwEDSolvt/END8LaQwap1MgdHiwDWL
	 7O0HmYy4M8LiA==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liao Chen <liaochen4@huawei.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	patrick.havelange@essensium.com
Subject: Re: [PATCH -next] counter: ftm-quaddec: Enable module autoloading
Date: Sat,  7 Sep 2024 20:20:46 +0900
Message-ID: <172570794715.339843.3334090626440270602.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902122014.905237-1-liaochen4@huawei.com>
References: <20240902122014.905237-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=373; i=wbg@kernel.org; h=from:subject:message-id; bh=f6blXwBybSGJsgti0bJ6UuW+qDDWWQjOZWHe47QN35A=; b=kA0DAAoWtUhWyr4SIysByyZiAGbcNwGik+IdgLYwQlIG5sontbEal8XgfBKUgPMXe3Xb4noKN 4h1BAAWCgAdFiEEjTfN3eDSJSj46J+2tUhWyr4SIysFAmbcNwEACgkQtUhWyr4SIyuSQQEA+sED Yh6nVyBk0lrJaDjzVgXycYcFYjINwVawNHhKi9QA/3TxmUiwXMesAnGta90v6sd25rGao4hk0m/ mqRsv6+0P
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 02 Sep 2024 12:20:14 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
> on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] counter: ftm-quaddec: Enable module autoloading
      commit: 0d0f611bdf8e1d06df7ecb44b424a6fb093e2efc

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

