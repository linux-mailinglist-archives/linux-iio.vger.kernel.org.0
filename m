Return-Path: <linux-iio+bounces-21757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDFB096ED
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12A11C46327
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FB22367DA;
	Thu, 17 Jul 2025 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no+6tIed"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE10192598;
	Thu, 17 Jul 2025 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791525; cv=none; b=u+OsvnkT1H7UkI4tLGYskKuRiCdxr+tQT6yjET3IgmAO3Zu4u9JGvbO4DT+mxLkMVi4zgIbxewnazXZVQTIE8Wr55XvEzWKwVUqn5uvTex6IcvA7NCPE2mxgJOjAJTY5nIBsyn2cOjqTWeypIzA5Z0yH8iMl26hCwjuheBvQT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791525; c=relaxed/simple;
	bh=7yzNKlQHR30Aa0DYesmEudSnaqO6t8rw18AiBQYmOcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4UDk/r/d4FAnEJWpzxHiVaJR0WIpbtKOi02kbxA6MJiQUQUrkTubGvmHqa1DHHOU5GRn/B4HNXcrnHXkanHC2VKsAjDWOAJSkAEdpoNVRnwIpzd6uqOkZgSPue0JTKVg09NT7m3OW75vy6/q996cARLUpGD6V+B5ZG1XNks9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no+6tIed; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-615a256240bso669110eaf.3;
        Thu, 17 Jul 2025 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752791523; x=1753396323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXirbcScWLR71U2qxf1CaCd+oxLYJPlVCKx0gOxF//8=;
        b=no+6tIedPpdFJmdyXeOYOL1jmp6aJOs7MNwuXuJLPyHM2pzBvyaVJ/ItBvDs7RfBle
         /AwNHhMNCd2+qEkuSbLv7oUt+cLmn5RNpimn6rhFtcZLHvnsiRe+wTBiDFkqOSl+wjtF
         JudtD6GK5MNJoJ6PZGYjq2QCDAtVMyn3YP2yaoSAGfK9Fsm2NPOMx/A3q6Je71+V3jXW
         KKbew7j7YQi+Pu015jQNKnUNaZjM6283/QSuY1G92rBm0rwt/7DT18bfDlI5RtJOQuRB
         OOJm1lvcmf5ll9K/8Iu/g5abZRf2iXOdh2xzytDLb8nudwF9a1p1sDJU5sJVc542e0KJ
         B3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752791523; x=1753396323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXirbcScWLR71U2qxf1CaCd+oxLYJPlVCKx0gOxF//8=;
        b=kJOVwBpJ6/Z/Rl7Jaz3U1wToAt8i0Yza8ylS9MS73r6u7zGlxm+nlqWu3YutC36U6N
         sgsPr8vXKf4/R0qx/bw8DpO8pBzx2E1eHpzMBH+NGY9pKwKnkW+od5lJ8qus+mf5LXZH
         rA9wnL9H4bn9sozh+cdZULC6Jmi88/PXx37FacZbzizNTtYnJMOX7PEST825B4HOBF5N
         3pDT1f2woEY+rydOTYTV8+NiVkl5MNCEDPVjvaojAZ5DwTA/gUmT4iAMq7sq6RKMCw7n
         vvP1lWxR0gflxdklPjesAHlewN86Yi/8SEzYlqo13wh+VpAdEi6Wn4fY/UHywHTy2VuO
         0EmA==
X-Forwarded-Encrypted: i=1; AJvYcCW3CfuX0dgQUypVfcs/cYo5N4vm2jAumHH0WJGTHOFnPAD5JsUeQvJWzLK8nrLwS7F4mqWt1+zjXZAU@vger.kernel.org, AJvYcCWS87l8jnUh+cM7ehvufde7KH+epEL2B9uIEEmpvrv1goygNkuEwswjGi8ale+o0zLuVvYnKSJ4tuub@vger.kernel.org, AJvYcCX2hKr6UxlenUm9SQsAGUE0DHU5w/XpK0YW8kcbI6uPWGAo82zN3DdvAnxuaRaSxzxENH2LTlOsUluU4kAE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BWzN/8dp2ZW3mK3WH+B42bqrIsumvBCj79wGWF1shoD/NODj
	0RAFpAgUyOASllYO0kaez5QgnCMMIesffUcpIHkYlS1N4LC3i5vHm/MeaKuYYkp6
X-Gm-Gg: ASbGncst00jaNdE+VFevVLuD5TlzhrX/TUXj9Lr4o0B13vzQDM2vhYd0v1I670Tnzpx
	yMcfwPxHYs4iSMo2Fq8gZyN++6CPoICRlsmZsZxvwSyNmJtKLjBgG4wsgxuOIrw7GZgbommTGox
	0iZffPnA0NgCajD5JV671/+Hv1/gpbIihSvz0qyi8fKDQCGrFz2OmbDXF4+I8slhzn75A2om2RE
	q0iz2AJFIilVPh3TdXkMkHyLBPbHqcBYG/E0Q2cAhJF2SnnCBQvQMZ5hHQxxjzuF6pJkBxOhVDo
	1dqgLKBcO4UuGS+ZbzDwU0KOXKTcLCpI39EIr9x6x394+SB6ILBSR5w1lxiCUQk8LnDiufhspsx
	bAs64vms/JJGVRbXzo3hAec5zeI+HeZkzGj27BTwsQMG9tA==
X-Google-Smtp-Source: AGHT+IEkFSyhQ0QDE9j5oBLn7J3qMLyDGBUtD6upmQANYknuQtTldz8VL2uV6FCQI2kqkWuAbbN5UA==
X-Received: by 2002:a05:6870:a44e:b0:29e:3921:b1ea with SMTP id 586e51a60fabf-2ffd25649f4mr3603542fac.30.1752791522812;
        Thu, 17 Jul 2025 15:32:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4133:553c:dd2c:6469])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30101784609sm105673fac.9.2025.07.17.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:32:01 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dlechner@baylibre.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add Garmin lidar-lite-v3
Date: Thu, 17 Jul 2025 19:24:34 -0300
Message-ID: <20250717223153.159878-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <8f4b72bb-3c5f-4137-a4f9-5ce94631d3c1@baylibre.com>
References: <8f4b72bb-3c5f-4137-a4f9-5ce94631d3c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> As a general rule of thumb, using the driver as justification for
> dt-bindings is never a good reason. The bindings describe the hardware,
> not the driver.

Looks like I`ve failed to double-check the datasheet here, sorry for that,
I`ll try to remember that in future occasions.

> Assuming I found the correct datasheet [1], I see a power enable pin
> and a mode control pin, so I would say that this isn't a trivial device.
> Therefore this will need it's own new file. We could at least add
> power-gpios and power-supply properties. How to handle the mode pin
> isn't so clear to me though, so might omit that for now.

Agree, actually, I was wondering here if the lidar-lite-v2 ref that I`ve found
when adding the grmn,lidar-lite-v3 is actually a trivial. 
It was originally added as trivial over txt file at [1] and then converted to yaml but
it looks like it is also not a trivial considering some refs at [2] and [3] (not official docs).
At those refs, I can see the same enable/mode pins.

Should we also move that out of trivial in a dedicated binding or should we keep as is
considering those docs are not official/device is very old?
Tks and regards!

[1] https://github.com/torvalds/linux/commit/12280bd3d5d7e1ba1dd60ba0bd4412f4056fc028
[2] https://www.electrokit.com/upload/product/41013/41013964/lidarlite2DS.pdf
[3] https://www.14core.com/wp-content/uploads/2017/03/LIDAR-Lite-v2-Datasheet.pdf


