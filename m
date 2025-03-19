Return-Path: <linux-iio+bounces-17113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3EA699BD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C37886AAB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77792214A6C;
	Wed, 19 Mar 2025 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7WcTP0a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E0214801
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413739; cv=none; b=IfA+cXqzWDhYDmZchggOW3DpcEHS0QN2/8JcbLTrkti6LptnituuIPxgfOjMjjCfpoa/ma1Bey9OWGg/AXluW4tQ7b56kxLvF/DXxYqukOpuOFF00z9KIrgTJzhMY50ckvPtbIWx/IQnPlu/WVZ4Y7JGuLnFz6kqgtmayRk4dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413739; c=relaxed/simple;
	bh=KKOdoYBjGYBmonnGmiInNmx8edoRs7hQSNrXiKwYHN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MskipWFmH+b2uJweuKY7NPMCgj5HxsNmJ1Vk8DyPeGUv0jqj0gavF5Glz8PgEPZTFo7LFeo9Jxyup33wG8ZvODi0d+hhDtNKvAgjavk4+ES5cx84o//ts0YuSFzuJTaZ8Ha9Sez86Oi/YQ70VUtJIXL6nEKq0T0dR/EryEmaBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7WcTP0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2144C4CEE9
	for <linux-iio@vger.kernel.org>; Wed, 19 Mar 2025 19:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742413738;
	bh=KKOdoYBjGYBmonnGmiInNmx8edoRs7hQSNrXiKwYHN4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=P7WcTP0a1Bg2ftFjAQTgKt3qwdZWT+s/izyHeBMtWN7SPRk77q4MYoxp+mUp7KRWh
	 ZuIpslhecma+cVWT6b5RPlVoToMdVjDW2hlkQ9zwE2o3uHIRWUtR6lgxamZSd+gVms
	 yuuZbvXBaCLheocZieQl8XdIh3fWDcp1LA4dJ8J0Jfv7vpIbAqqXfrSaF1dtBrbAFB
	 BT1W/Kqj6uaXY6IO9qQ2NmxDvDAi+NvTTRid63APUTNwf4Himq8vc/GI+phlb57Q4G
	 azLu5eqYh9ePPFRUckT6Ra0DVaUx702qTqSBGD1SLv5bYUaZLHswkAEsZNOKj1806X
	 ynQ8R57ypl0Dw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FC32C41612; Wed, 19 Mar 2025 19:48:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-iio@vger.kernel.org
Subject: [Bug 219890] illuminance sensor is jittering between correct value
 and 0.03lux
Date: Wed, 19 Mar 2025 19:48:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: IIO
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wysiwyg81@rbox.co
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_iio@kernel-bugs.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219890-217253-OSxgYLk6S2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219890-217253@https.bugzilla.kernel.org/>
References: <bug-219890-217253@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D219890

--- Comment #22 from Fred (wysiwyg81@rbox.co) ---
it's big file :)
I found this section, by searching "Sensors.DataFieldIlluminance".=20
is it what you looking for ?


    Field(2)
      Physical(Sensors.LightAmbientLight)
      Application(Sensors.Sensor)
      Usage(1)
        Sensors.DataFieldIlluminance
      Logical Minimum(0)
      Logical Maximum(-1)
      Unit Exponent(-2)
      Report Size(32)
      Report Count(1)
      Report Offset(16)
      Flags( Variable Absolute

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

