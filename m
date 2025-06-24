Return-Path: <linux-iio+bounces-20934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0BAE5A76
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 05:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F8918874CC
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19999202F65;
	Tue, 24 Jun 2025 03:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNQeg8Fg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79017A2F8
	for <linux-iio@vger.kernel.org>; Tue, 24 Jun 2025 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750735480; cv=none; b=V3V5WqLJ99vTz+EiOWJi/V+Af85tad1Wx3Cl/BokYpr02C9N3tTGIrWNKFCvJxeOAk1sCywDfPwjeR6xrrdbtd10aENjZWz+vAlXgIL3wmt+6m2YwqLlwyvw9RclcbN1xrpajw3CmE0i+PMBnREW2+jjNB5s23m6XoOcp9dlsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750735480; c=relaxed/simple;
	bh=A18mPcFzj7x/9SfA9+YBM6V2Bgu/HPCpdwcFxHdOTI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD5BeTTyccwKQrha2eulpS4NodR9OC1f1I4fD6f9EY04fB0kNnf2gcC4xe9d2DHHluONIulkJQdPXgUcbydGY7nEc6viPtZNjFRb0XST77TWTeuOHYyKDBya00PJ6lSJfjCgqpAATHM1bXNYLVcUkvLIPa6qzCmx8brrTOrSKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VNQeg8Fg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5313a2566f9so3391702e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Jun 2025 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750735478; x=1751340278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A18mPcFzj7x/9SfA9+YBM6V2Bgu/HPCpdwcFxHdOTI4=;
        b=VNQeg8FgYRZ0MGJ4XopHJtQRM4ahUMSR0slFEVReiTzmElVWNQVGFqv3LWF1terwE8
         IXRVVhdnnEhRGW5mw3m07Cl2mVVDqLX81zfW2hYz5nuageezffwdc8mbrFyXRHr5TWlp
         ae0kPkTcpO5p0qfwaONf3KozCrOIaco7R65pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750735478; x=1751340278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A18mPcFzj7x/9SfA9+YBM6V2Bgu/HPCpdwcFxHdOTI4=;
        b=tkDrY5N4zIvoSMCIz33wzIrlLHACdaajFR45O2xCMsEIEUgpbqek5t136pbrQvTwP/
         W8U92PZDsJDx34YUd4GyU/xB2X2O99e77/gI2MVtTGv5QX8WprZYBxCnny+VsqC1YXyk
         nSBYvByDPXgJlpDeQErjBTbjpOT8hjqVqdsqVoMsknhzouFMSy2RIuzUAAi6MhyYOwDO
         yEO8dUTmpl8wIA5YhfZdBGy8VdTNLL5ato/jvR+O6hztsqeGZ5bv8Us1O+E6grZiEUoI
         o3C5mnjsfcb6YUoXVP58N/vb5GK4SkGFP+Jim/YHFpiA9DcUPcqxqkvdqB3j/+iRVyfs
         t+7A==
X-Forwarded-Encrypted: i=1; AJvYcCUoyqAsY/OZFPch77Ees57tT60gxYK+gTQt7Y62/MQWEnyc3DoSjatJSSkWEM9eWKXG7YIjkrw4axU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdLu19hOD9sUwieEGoXcG5tCerktmXv05ojljFqw9ifHkmEae
	EDwgQwld4U75n0Jm80F1jAivxpOrubLV3lLADgLhP0eAFNIq8DBakhoiIO0RyvAKb5p5hHNn3ue
	picCO/J7Z0VLWGXhrVMAkkxVmXGOen1TXcOy1agm+
X-Gm-Gg: ASbGncv4pASnLtOhydAI2RXEk77Q7n6JMt6YJylqfYuSG2s0dOfGVVm6qr8mMxqW+ZQ
	hipnqV8h/ZbvfvkAgBM9fXLnl6N9bVE72rj3eBRBh+a2GkP0qbUb22dMxQ7UxTP219XCwZnppfp
	yF9/hGEPQenY8N6X5FYzRqpdLVHfbPn26jkvXmydNJPZw=
X-Google-Smtp-Source: AGHT+IFNYMnscvSgYO2AT8l9jsnQ7oqyyTtyeX2nCvFqmYCEYP7Db1MOT+7UMgFSpQs8W5qd0mijj3mr9SxxAHYaRbo=
X-Received: by 2002:a05:6122:438b:b0:530:71e7:37eb with SMTP id
 71dfb90a1353d-531ad693f93mr8412153e0c.10.1750735478321; Mon, 23 Jun 2025
 20:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623185153.222714-1-gwendal@google.com> <aFoL86kzENM2jMqi@google.com>
In-Reply-To: <aFoL86kzENM2jMqi@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 23 Jun 2025 20:24:25 -0700
X-Gm-Features: AX0GCFszXx7J3AbEhN26GzsevDL5HNCwGCF0GKeR-hT7uUV5XXAQAnodsCHrUwk
Message-ID: <CAPUE2us7htmAC1x1sTHYKSuSgx9sTLE-sV2RuFpcNhxc9dy5nA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_activity: Fix function casting error
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: jic23@kernel.org, chrome-platform@lists.linux.dev, 
	linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 7:22=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Jun 23, 2025 at 11:51:52AM -0700, Gwendal Grignou wrote:
> > .write_event_configwrite_event_config expects |state| to be an int not =
a
> > bool:
>
> No, `state` is a bool since commit b4b42f28a0df
> ("iio: fix write_event_config signature").
Correct, I just realized my mistake. Please ignore this patch as well...

Gwendal.
>

