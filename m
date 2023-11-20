Return-Path: <linux-iio+bounces-202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9F7F1DFA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 21:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13521C21242
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76242374D5;
	Mon, 20 Nov 2023 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJqmfgyA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F8DE8;
	Mon, 20 Nov 2023 12:23:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd64814fso6708038e87.1;
        Mon, 20 Nov 2023 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700511803; x=1701116603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKHqxNOb0s+yYoiwVra6G4KKWe01UXwqHln/ApyC2m4=;
        b=UJqmfgyAh/3nLkP39+aMZROgvKTO5UM0D+r+M923uueKERFDqUOv2DUdvDXN7PPR9D
         rOAGTGqPzSv0+G94kJw2BhceK0zmUexZEB1e9VAxwHTofK9ExPlGJdVajz36ph7L4iUB
         76CTS6IFHvKC+jn4vvFiR9W8sKOMMNwI9Y3T/qOREZqH4PYi0B5Pdf2zplOjvgPDBR7o
         BgsJIms2TFJ/yFGXo9J32mDWu/46uwqqUojnPK4E4/hTaftYaOdJJSXJYputnAoaIxAn
         H4RLsFtC19YjQ1dGQ3rY+kneV3qDx3Mtrdsm+lTh68/nsr1Wuqvpqqzp9GTzKvnNQuKz
         EsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511803; x=1701116603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKHqxNOb0s+yYoiwVra6G4KKWe01UXwqHln/ApyC2m4=;
        b=Goz24CwTX538ynYYf5bELA6T4cm8i7NjzjSxykkeMiRZlpKkYojVHw3W1CvYSWJI9x
         UBZtc+1PwM1aLDlS2rC/w1+7ONeOJsLxJlQTam935pNTDq/MXoES2eMJgXQTPWa0b31f
         ry8QCtkWanMX2JcJnrdsMG6e32W1RxEkQ5JaSXwc4wAsA1fF0qF7Fci9G90fJMhmFpH/
         TIOkTsPHIv5NB8KHuVDHQH6PWO4NJSO7FdPkakOc7BEt//zHVx4WS3fHaXtlaI3HLifK
         GJaMn7oGlhQbpLbWF44EVkOKDf5ZPXG7cgLRqmijOYbyx3myBpxTs3huyxjybdIaf/su
         +YCQ==
X-Gm-Message-State: AOJu0YwFoYS/YRd825lUuzBHkdXVzom30AnOf+ITTJlciMX34DB1mEqp
	0tuvwanjtN4TK7bdKglVn48=
X-Google-Smtp-Source: AGHT+IFhXcnX4W2V7BVPtVW8s0A9taRDZ0J2v7bLApCBOk+kw4ysyv1kTbiCoFZmZAbjQLPwtNoywQ==
X-Received: by 2002:a05:651c:3da:b0:2c8:7443:d111 with SMTP id f26-20020a05651c03da00b002c87443d111mr4938734ljp.10.1700511803167;
        Mon, 20 Nov 2023 12:23:23 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id uz4-20020a170907118400b009fc2a76ddedsm2357663ejb.17.2023.11.20.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:23:22 -0800 (PST)
Date: Mon, 20 Nov 2023 22:23:13 +0200
From: Sicelo <absicsz@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: supporting binary (near-far) proximity sensors over gpio
Message-ID: <ZVvAMbggKe9WLmw1@tp440p.steeds.sam>
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
 <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
 <20231120173131.000058a2@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120173131.000058a2@Huawei.com>

Hi

On Mon, Nov 20, 2023 at 05:31:31PM +0000, Jonathan Cameron wrote:
> > Since this is really a proximity switch (it is either on or off)
> > rather than measuring a proximity value over a continuous range, it
> > doesn't seem like a good fit for the iio subsystem. If the sensor is
> > on a phone, then it is likely to detect human presence so the input
> > subsystem does seem like the right one for that application.
> > 
> > More at https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html
> > 
> Agreed.  This one at least has a working distance of 30mm sensor, so
> definitely switch type usecases where input tends to be the right choice.
> 
> If we wanted to use proximity range sensor for this usecase, we'd probably
> bridge it to input (maybe in userspace, maybe in kernel) from the
> underlying IIO driver.
> 
> Jonathan

Thank you so much for the input. It makes sense.

Sincerely
Sicelo

